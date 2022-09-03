Code.require_file("../test_helpers.exs", __DIR__)

defmodule ExTicTacToe.Engine.StateTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe.Engine.State
  alias State.Board
  alias Board.Helpers, as: BoardHelpers
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

  test "State.new/2" do
    {x, y} = {2, 2}
    board = Board.new(x, y)

    assert State.new(2, 2) ===
             %State{
               winning_intersections: %{
                 x: BoardHelpers.winning_intersections(:x, {x, y}),
                 o: BoardHelpers.winning_intersections(:o, {x, y})
               },
               phase: :init,
               board: board,
               blank_board: board
             }
  end

  test "State.mark/3" do
    assert State.mark(new_game_3x3(first: :x), :x, {0, 0}).board.topology ===
             MapSet.new([
               %{{0, 0} => :x},
               %{{0, 1} => nil},
               %{{0, 2} => nil},
               %{{1, 0} => nil},
               %{{1, 1} => nil},
               %{{1, 2} => nil},
               %{{2, 0} => nil},
               %{{2, 1} => nil},
               %{{2, 2} => nil}
             ])

    assert State.mark(new_game_3x3(first: :o), :o, {0, 1}).board.topology ===
             MapSet.new([
               %{{0, 0} => nil},
               %{{0, 1} => :o},
               %{{0, 2} => nil},
               %{{1, 0} => nil},
               %{{1, 1} => nil},
               %{{1, 2} => nil},
               %{{2, 0} => nil},
               %{{2, 1} => nil},
               %{{2, 2} => nil}
             ])

    assert_raise ArgumentError, fn -> State.mark(new_game_3x3(first: :o), :z, {0, 1}) end
  end
end
