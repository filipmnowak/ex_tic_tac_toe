defmodule ExTicTacToe.Engine do
  use ExTicTacToe.Types

  alias ExTicTacToe.Engine.State
  require ExTicTacToe.Engine.State

  def init(x_max, y_max, next_move \\ :random) when next_move in [:x, :o, :random] do
    State.new(x_max, y_max)
    |> Map.put(:turn, 1)
    |> Map.put(:next_move, (next_move == :random && State.whos_turn?()) || next_move)
    |> Map.put(:phase, State.game_on())
  end

  def phase(state), do: state.phase

  def mark(state, x_or_o, {x, y}) do
    State.mark(state, x_or_o, {x, y})
  end

  def progress_game(%State{phase: phase} = state, _)
      when phase in [State.draw(), State.x_won(), State.o_won()] do
    state
  end

  # reset state to eval next attemp
  def progress_game(%State{phase: phase} = state, updated_state)
      when phase == State.illegal_state() do
    progress_game(%State{state | phase: State.game_on()}, updated_state)
  end

  def progress_game(%State{phase: phase} = state, updated_state) when phase == State.game_on() do
    case State.state(state, updated_state) do
      State.game_on() ->
        %State{updated_state | phase: State.game_on()}
        |> Map.get_and_update(:turn, &{&1, &1 + 1})
        |> elem(1)
        |> Map.get_and_update(:next_move, fn v -> {v, State.whos_turn?(v)} end)
        |> elem(1)

      State.x_won() ->
        %State{updated_state | phase: State.x_won()}

      State.o_won() ->
        %State{updated_state | phase: State.o_won()}

      State.draw() ->
        %State{updated_state | phase: State.draw()}

      State.illegal_state() ->
        %State{state | phase: State.illegal_state()}
    end
  end
end
