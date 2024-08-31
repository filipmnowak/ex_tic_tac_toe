Code.require_file("test_helpers.exs", __DIR__)

defmodule ExTicTacToe.EngineTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe.Engine, as: Eng
  alias ExTicTacToe.Engine.State
  require State
  import ExTicTacToe.TestHelpers

  test "Engine.init/3 - base cases" do
    assert_on_state(Eng.init(2, 2, :x) === game_3x3(phase: :new, first: :x))
    assert_on_state(Eng.init(2, 2, :o) !== game_3x3(phase: :new, first: :x))
    assert_on_state(Eng.init(2, 2, :o) === game_3x3(phase: :new, first: :o))
    assert_on_state(Eng.init(2, 2, :x) !== game_3x3(phase: :new, first: :o))
  end

  test "Engine.init/3 - allowed input" do
    assert_on_state(Eng.init(1, 1, :x) === game_2x2(phase: :new, first: :x))
    assert_on_state(Eng.init(2, 2, :x) === game_3x3(phase: :new, first: :x))
    assert_on_state(Eng.init(1, 1, :o) === game_2x2(phase: :new, first: :o))
    assert_on_state(Eng.init(2, 2, :o) === game_3x3(phase: :new, first: :o))

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

  test "Engine.progress_game/2 - noop on draw or already won game" do
    assert_on_state(game_2x2(phase: :x_won) === Eng.progress_game(game_2x2(phase: :x_won), nil))
    assert_on_state(game_2x2(phase: :o_won) === Eng.progress_game(game_2x2(phase: :o_won), nil))
    assert_on_state(game_2x2(phase: :draw) === Eng.progress_game(game_2x2(phase: :draw), nil))
  end

  test "Engine.progress_game/2 - reset `illegal_state` to eval again" do
    assert_on_state(
      Eng.progress_game(
        game_2x2(phase: :illegal_state),
        game_2x2(phase: :game_on) |> Eng.mark(:x, {0, 1})
      ) ===
        Eng.progress_game(
          game_2x2(phase: :game_on),
          game_2x2(phase: :game_on) |> Eng.mark(:x, {0, 1})
        )
    )
  end

  test "Engine.progress_game/2 - x won" do
    game =
      Enum.reduce(
        [{0, 0}, {1, 0}, {0, 1}, {1, 1}],
        game_3x3(phase: :new, first: :x),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert Eng.progress_game(game, Eng.mark(game, :x, {0, 2})) |> State.phase() === {:won, :x}
  end

  test "Engine.progress_game/2 - o won" do
    game =
      Enum.reduce(
        [{0, 0}, {1, 0}, {0, 1}, {1, 1}],
        game_3x3(phase: :new, first: :o),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert Eng.progress_game(game, Eng.mark(game, :o, {0, 2})) |> State.phase() === {:won, :o}
  end

  test "Engine.progress_game/2 - illegal state" do
    game =
      Enum.reduce(
        [{0, 0}],
        game_3x3(phase: :new, first: :x),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert Eng.progress_game(game, Eng.mark(game, :x, {0, 0})) |> State.phase() === State.illegal_state()

    assert Eng.progress_game(game, Eng.mark(game, :x, {1000, 0})) |> State.phase() === State.illegal_state()

    assert Eng.progress_game(game, Eng.mark(game, :x, {0, 1}) |> Eng.mark(:x, {0, 2})) |> State.phase() === State.illegal_state()
  end

  test "Engine.progress_game/2 - draw" do
    game =
      Enum.reduce(
        [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {1, 2}, {0, 2}, {2, 0}, {2, 1}],
        game_3x3(phase: :new, first: :x),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert Eng.progress_game(game, Eng.mark(game, :x, {2, 2})) |> State.phase() === {:draw, nil}
  end

  test "Engine.progress_game/2 - game on" do
    game = game_3x3(phase: :new, first: :x)

    assert Eng.progress_game(game, Eng.mark(game, :x, {2, 2})) |> State.phase() === {:game_on, nil}
  end

  test "Engine.restart_from/2 - two moves" do
    after_restart_topology =
      MapSet.new([
        %{{0, 0} => :x},
        %{{0, 1} => :o},
        %{{0, 2} => nil},
        %{{1, 0} => nil},
        %{{1, 1} => nil},
        %{{1, 2} => nil},
        %{{2, 0} => nil},
        %{{2, 1} => nil},
        %{{2, 2} => nil}
      ])

    before_restart_topology =
      MapSet.new([
        %{{0, 0} => :x},
        %{{0, 1} => :o},
        %{{0, 2} => :x},
        %{{1, 0} => :o},
        %{{1, 1} => :x},
        %{{1, 2} => nil},
        %{{2, 0} => nil},
        %{{2, 1} => nil},
        %{{2, 2} => nil}
      ])

    game =
      Enum.reduce(
        [{0, 0}, {0, 1}, {0, 2}, {1, 0}, {1, 1}],
        game_3x3(phase: :new, first: :x),
        fn coords, acc ->
          Eng.progress_game(acc, Eng.mark(acc, acc.next_move, coords))
        end
      )

    assert MapSet.equal?(game.board.topology, before_restart_topology)
    assert MapSet.equal?(Eng.restart_from(game, 1).board.topology, after_restart_topology)
  end
end
