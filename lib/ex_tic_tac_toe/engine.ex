defmodule ExTicTacToe.Engine do
  use ExTicTacToe.Types

  alias ExTicTacToe.Engine.State
  require ExTicTacToe.Engine.State

  def init(x_max, y_max) do
    State.new(x_max, y_max)
    |> Map.put(:turn, 1)
    |> Map.put(:next_move, State.whos_turn?())
    |> Map.put(:phase, :game_on)
  end

  def mark(state, x_or_o, {x, y}) do
    State.mark(state, x_or_o, {x, y})
  end

  def progress_game(%State{phase: phase} = state, _)
      when phase in [:draw, State.x_won(), State.o_won()] do
    state
  end

  def progress_game(%State{phase: phase} = state, updated_state)
      when phase in [:game_on, :illegal_state] do
    case State.state(state, updated_state) do
      {:game_on, _} ->
        updated_state
        |> Map.get_and_update(:turn, &{&1, &1 + 1})
        |> elem(1)
        |> Map.get_and_update(:next_move, fn v -> {v, State.whos_turn?(v)} end)
        |> elem(1)

      State.x_won() ->
        %State{updated_state | phase: State.x_won()}

      State.o_won() ->
        %State{updated_state | phase: State.o_won()}

      _ ->
        state
    end
  end
end
