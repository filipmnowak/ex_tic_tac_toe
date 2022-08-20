defmodule ExTicTacToe.Types.Guards do
  defguard is_non_neg_integer(n) when is_integer(n) and n >= 0
  defguard is_non_pos_integer(n) when is_integer(n) and n > 0
end
