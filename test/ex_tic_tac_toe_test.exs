Code.require_file("ex_tic_tac_toe/helpers.exs", __DIR__)

defmodule ExTicTacToeTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe, as: TTT
  import TTT.TestHelpers

  test "ExTicTacToe.init/3 - base cases" do
    assert TTT.init(2, 2, :x) === new_game_3x3(first: :x)
    assert TTT.init(2, 2, :o) != new_game_3x3(first: :x)
    assert TTT.init(2, 2, :o) === new_game_3x3(first: :o)
    assert TTT.init(2, 2, :x) != new_game_3x3(first: :o)
    assert TTT.init(2, 2) in [new_game_3x3(first: :o), new_game_3x3(first: :x)]
  end

  test "ExTicTacToe.init/3 - allowed input" do
    assert TTT.init(1, 1, :x) === new_game_2x2(first: :x)
    assert TTT.init(2, 2, :x) === new_game_3x3(first: :x)
    assert TTT.init(1, 2) === {:err, :bad_args}
    assert TTT.init(2, 1) === {:err, :bad_args}
    assert TTT.init(-1, -1) === {:err, :bad_args}
    assert TTT.init(0, 0) === {:err, :bad_args}
  end
end
