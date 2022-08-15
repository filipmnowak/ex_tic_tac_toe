Code.require_file("ex_tic_tac_toe/helpers.exs", __DIR__)

defmodule ExTicTacToeTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe, as: TTT
  import TTT.TestHelpers

  test "test init - base cases" do
    assert TTT.init(2, 2, :x) === new_game_first()
    assert TTT.init(2, 2, :o) != new_game_3x3_x_first()
    assert TTT.init(2, 2, :o) === new_game_3x3_o_first()
    assert TTT.init(2, 2) in [new_game_3x3_o_first(), new_game_3x3_x_first()]
  end
end
