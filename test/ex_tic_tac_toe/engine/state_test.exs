Code.require_file("../test_helpers.exs", __DIR__)

defmodule ExTicTacToe.Engine.StateTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe.Engine.State, as: State
  require State
  import ExTicTacToe.TestHelpers

  test "State.x_won/0" do
    assert State.x_won() === {:won, :x}
  end

  test "State.o_won/0" do
    assert State.o_won() === {:won, :o}
  end

  test "State.draw/0" do
    assert State.draw() === {:draw, nil}
  end

  test "State.game_on/0" do
    assert State.game_on() === {:game_on, nil}
  end

  test "State.illegal_state/0" do
    assert State.illegal_state() === {:illegal_state, nil}
  end

  test "State.repeat_turn/1" do
    assert State.repeat_turn(:x) === :x
    assert State.repeat_turn(:o) === :o
  end

  test "State.whos_turn?/0" do
    assert State.whos_turn?() in [:x, :o]
  end

  test "State.whos_turn?/1" do
    assert State.whos_turn?(:o) === :x
    assert State.whos_turn?(:x) === :o
  end
end
