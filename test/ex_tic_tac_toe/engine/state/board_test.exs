Code.require_file("../../test_helpers.exs", __DIR__)

defmodule ExTicTacToe.Engine.State.BoardTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe.Engine.State.Board

  test "Board.new/2 - basic board" do
    assert(
      Board.new(2, 2) ===
        %ExTicTacToe.Engine.State.Board{
          topology:
            MapSet.new([
              %{{0, 0} => nil},
              %{{0, 1} => nil},
              %{{0, 2} => nil},
              %{{1, 0} => nil},
              %{{1, 1} => nil},
              %{{1, 2} => nil},
              %{{2, 0} => nil},
              %{{2, 1} => nil},
              %{{2, 2} => nil}
            ]),
          dimmensions: %{x: 2, y: 2}
        }
    )
  end

  test "Board.new/2 - bad args" do
    assert_raise(ArgumentError, fn -> Board.new(1, 2) end)
    assert_raise(ArgumentError, fn -> Board.new(1, -2) end)
  end

  test "Board.mark/2" do
    board = Board.new(2, 2)

    assert(
      Board.mark(board, :x, {0, 0}) ===
        %ExTicTacToe.Engine.State.Board{
          topology:
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
            ]),
          dimmensions: %{x: 2, y: 2}
        }
    )

    assert(
      Board.mark(board, :o, {1, 0}) ===
        %ExTicTacToe.Engine.State.Board{
          topology:
            MapSet.new([
              %{{0, 0} => nil},
              %{{0, 1} => nil},
              %{{0, 2} => nil},
              %{{1, 0} => :o},
              %{{1, 1} => nil},
              %{{1, 2} => nil},
              %{{2, 0} => nil},
              %{{2, 1} => nil},
              %{{2, 2} => nil}
            ]),
          dimmensions: %{x: 2, y: 2}
        }
    )
  end

  test "Board.mark/2 - bad args" do
    board = Board.new(2, 2)
    assert_raise(ArgumentError, fn -> Board.mark(board, :z, {0, 0}) end)
    assert_raise(ArgumentError, fn -> Board.mark(%{}, :o, {0, 0}) end)
  end
end
