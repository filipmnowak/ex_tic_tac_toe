Code.require_file("test_helpers.exs", __DIR__)

defmodule ExTicTacToe.EngineTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe.Engine, as: Eng
  import ExTicTacToe.TestHelpers

  test "Engine.init/3 - base cases" do
    assert Eng.init(2, 2, :x) === new_game_3x3(first: :x)
    assert Eng.init(2, 2, :o) != new_game_3x3(first: :x)
    assert Eng.init(2, 2, :o) === new_game_3x3(first: :o)
    assert Eng.init(2, 2, :x) != new_game_3x3(first: :o)
    assert Eng.init(2, 2) in [new_game_3x3(first: :o), new_game_3x3(first: :x)]
  end

  test "Engine.init/3 - allowed input" do
    assert Eng.init(1, 1, :x) === new_game_2x2(first: :x)
    assert Eng.init(2, 2, :x) === new_game_3x3(first: :x)
    assert Eng.init(1, 1, :o) === new_game_2x2(first: :o)
    assert Eng.init(2, 2, :o) === new_game_3x3(first: :o)

    assert Eng.init(1, 2) === {:err, :bad_args}
    assert Eng.init(2, 1) === {:err, :bad_args}
    assert Eng.init(-1, -1) === {:err, :bad_args}
    assert Eng.init(0, 0) === {:err, :bad_args}

    assert Eng.init(1, 2, :x) === {:err, :bad_args}
    assert Eng.init(2, 1, :x) === {:err, :bad_args}
    assert Eng.init(-1, -1, :x) === {:err, :bad_args}
    assert Eng.init(0, 0, :x) === {:err, :bad_args}

    assert Eng.init(1, 2, :o) === {:err, :bad_args}
    assert Eng.init(2, 1, :o) === {:err, :bad_args}
    assert Eng.init(-1, -1, :o) === {:err, :bad_args}
    assert Eng.init(0, 0, :o) === {:err, :bad_args}
  end

  test "Engine.phase/1" do
    assert new_game_2x2(first: :x) |> Eng.phase() === {:game_on, nil}
    assert game_2x2(phase: :o_won) |> Eng.phase() === {:won, :o}
    assert game_2x2(phase: :x_won) |> Eng.phase() === {:won, :x}
    assert game_2x2(phase: :illegal_state) |> Eng.phase() === {:illegal_state, nil}
    assert game_2x2(phase: :draw) |> Eng.phase() === {:draw, nil}
  end

  test "Engine.mark/3" do
    assert update_in(
             new_game_2x2(first: :x).board.topology,
             &(&1 |> MapSet.delete(%{{0, 0} => nil}) |> MapSet.put(%{{0, 0} => :x}))
           ) === Eng.mark(new_game_2x2(first: :x), :x, {0, 0})

    assert update_in(
             new_game_2x2(first: :x).board.topology,
             &(&1 |> MapSet.put(%{{10, 10} => :x}))
           ) === Eng.mark(new_game_2x2(first: :x), :x, {10, 10})
  end

  test "Engine.progress_game/2 - noop on draw or already won game" do
    assert game_2x2(phase: :x_won) === Eng.progress_game(game_2x2(phase: :x_won), nil)
    assert game_2x2(phase: :o_won) === Eng.progress_game(game_2x2(phase: :o_won), nil)
    assert game_2x2(phase: :draw) === Eng.progress_game(game_2x2(phase: :draw), nil)
  end

  test "Engine.progress_game/2 - reset `illegal_state` to eval again" do
    assert Eng.progress_game(
             game_2x2(phase: :illegal_state),
             game_2x2(phase: :game_on) |> Eng.mark(:x, {0, 1})
           ) ===
             Eng.progress_game(
               game_2x2(phase: :game_on),
               game_2x2(phase: :game_on) |> Eng.mark(:x, {0, 1})
             )
  end

  test "Engine.progress_game/2 - x won" do
    game =
      Enum.reduce(
        [{0, 0}, {1, 0}, {0, 1}, {1, 1}],
        new_game_3x3(first: :x),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert Eng.progress_game(game, Eng.mark(game, :x, {0, 2})) |> Eng.phase() === {:won, :x}
  end

  test "Engine.progress_game/2 - o won" do
    game =
      Enum.reduce(
        [{0, 0}, {1, 0}, {0, 1}, {1, 1}],
        new_game_3x3(first: :o),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert Eng.progress_game(game, Eng.mark(game, :o, {0, 2})) |> Eng.phase() === {:won, :o}
  end

  test "Engine.progress_game/2 - illegal state" do
    game =
      Enum.reduce(
        [{0, 0}],
        new_game_3x3(first: :x),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert Eng.progress_game(game, Eng.mark(game, :x, {0, 0})) |> Eng.phase() ===
             {:illegal_state, nil}

    assert Eng.progress_game(game, Eng.mark(game, :x, {1000, 0})) |> Eng.phase() ===
             {:illegal_state, nil}

    assert Eng.progress_game(game, Eng.mark(game, :x, {0, 1}) |> Eng.mark(:x, {0, 2}))
           |> Eng.phase() ===
             {:illegal_state, nil}
  end

  test "Engine.progress_game/2 - draw" do
    game =
      Enum.reduce(
        [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {1, 2}, {0, 2}, {2, 0}, {2, 1}],
        new_game_3x3(first: :x),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert Eng.progress_game(game, Eng.mark(game, :x, {2, 2})) |> Eng.phase() ===
             {:draw, nil}
  end

  test "Engine.progress_game/2 - game on" do
    game = new_game_3x3(first: :x)

    assert Eng.progress_game(game, Eng.mark(game, :x, {2, 2})) |> Eng.phase() ===
             {:game_on, nil}
  end
end
