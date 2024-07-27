defmodule ExTicTacToe.Engine do
  use ExTicTacToe.Types
  import ExTicTacToe.Types.Guards

  alias ExTicTacToe.Engine.State
  require State

  defdelegate mark(state, x_or_o, x_and_y), to: State

  def init(x_max, y_max, next_move \\ :random)

  def init(x_max, y_max, next_move)
      when next_move in [:x, :o, :random] and
             is_pos_integer(x_max) and
             is_pos_integer(y_max) and
             x_max == y_max do
    State.new(x_max, y_max)
    |> Map.put(:turn, 1)
    |> Map.put(:next_move, (next_move == :random && State.whos_turn?()) || next_move)
    |> Map.get_and_update(:journal, fn v -> {v, v ++ [{Time.utc_now(), :init, nil}]} end)
    |> elem(1)
    |> Map.put(:phase, State.game_on())
  end

  def init(x_max, y_max, next_move) do
    {x_max, y_max, next_move}
    # {:err, :bad_args}
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

  # noop
  def restart_from(state, turn)
      when is_struct(state, State) and is_non_neg_integer(turn) and turn == state.turn do
    state
  end

  def restart_from(state, turn)
      when is_struct(state, State) and is_non_neg_integer(turn) and turn <= state.turn do
    journal = Enum.filter(state.journal, fn e -> elem(e, 1) in [:x, :o] end)
    [{_, whos_turn, _} | _] = journal

    moves =
      Enum.map(journal, fn e -> elem(e, 2) end)
      |> Enum.slice(0, turn + 1)

    Enum.reduce(
      moves,
      init(state.board.dimmensions.x, state.board.dimmensions.y, whos_turn),
      fn coords, acc ->
        progress_game(acc, mark(acc, acc.next_move, coords))
      end
    )
  end

  # TODO: add error details
  def restart_from(_, _) do
    {:err, :bad_args}
  end
end
