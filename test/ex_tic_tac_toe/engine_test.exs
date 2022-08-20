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
    assert game(phase: :o_won) |> Eng.phase() === {:won, :o}
    assert game(phase: :x_won) |> Eng.phase() === {:won, :x}
    assert game(phase: :illegal_state) |> Eng.phase() === {:illegal_state, nil}
    assert game(phase: :draw) |> Eng.phase() === {:draw, nil}
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
end
