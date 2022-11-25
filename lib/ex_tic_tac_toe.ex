defmodule ExTicTacToe do
  alias ExTicTacToe.Engine
  alias ExTicTacToe.Engine.State

  defdelegate init(x_max, y_max, first_move \\ :random), to: Engine
  defdelegate phase(state), to: State
  defdelegate mark(state, x_or_o, x_and_y), to: Engine
  defdelegate progress_game(state, updated_state), to: Engine
end
