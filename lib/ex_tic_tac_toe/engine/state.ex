defmodule ExTicTacToe.Engine.State do
  alias ExTicTacToe.Engine.State.Board
  alias ExTicTacToe.Engine.State.Board.Helpers, as: BoardHelpers

  defstruct(
    winning_intersections: nil,
    phase: nil,
    turn: nil,
    next_move: nil,
    board: nil,
    blank_board: nil
  )

  defmacro x_won(), do: {:won, :x}
  defmacro o_won(), do: {:won, :o}
  defmacro draw(), do: {:draw, nil}
  defmacro game_on(), do: {:game_on, nil}
  defmacro illegal_state(), do: {:illegal_state, nil}

  def repeat_turn(:o), do: :o
  def repeat_turn(:x), do: :x
  def whos_turn?(), do: Enum.random([:x, :o])
  def whos_turn?(:x), do: :o
  def whos_turn?(:o), do: :x

  def new(x_max, y_max) do
    board = Board.new(x_max, y_max)

    %__MODULE__{
      winning_intersections: %{
        x: BoardHelpers.winning_intersections(:x, {x_max, y_max}),
        o: BoardHelpers.winning_intersections(:o, {x_max, y_max})
      },
      phase: :init,
      board: board,
      blank_board: board
    }
  end

  def phase(state), do: state.phase

  def mark(state, x_or_o, {x, y}) do
    %__MODULE__{state | board: Board.mark(state.board, x_or_o, {x, y})}
  end

  def won?(state) do
    board = state.board

    Enum.reduce_while(
      state.winning_intersections.x,
      false,
      fn i, _acc ->
        (MapSet.intersection(board.topology, i) == i && {:halt, x_won()}) || {:cont, false}
      end
    ) ||
      Enum.reduce_while(
        state.winning_intersections.o,
        false,
        fn i, _acc ->
          (MapSet.intersection(board.topology, i) == i && {:halt, o_won()}) || {:cont, false}
        end
      )
  end

  def draw?(state) do
    # hack: updated state holds new mark, however turn is not yet updated.
    state.turn == (state.board.dimmensions.x + 1) * (state.board.dimmensions.x + 1) && draw()
  end

  def illegal?(current_state, updated_state) do
    {current_board, updated_board} = {current_state.board, updated_state.board}
    blank_board = current_state.blank_board
    diff = MapSet.difference(updated_board.topology, current_board.topology)

    cond do
      # too many changes at once
      MapSet.size(diff) > 1 ->
        illegal_state()

      # no changes
      MapSet.size(diff) == 0 ->
        illegal_state()

      # possibly new field added
      MapSet.size(current_board.topology) != MapSet.size(updated_board.topology) ->
        illegal_state()

      # set of all marked fields from the current board, needs to be a subset of all marked fields in
      # the updated board. marked fields can't be changed.
      MapSet.subset?(
        MapSet.difference(current_board.topology, blank_board.topology),
        MapSet.difference(updated_board.topology, blank_board.topology)
      ) === false ->
        illegal_state()

      diff ->
        false
    end
  end

  def state(current_state, updated_state) do
    illegal?(current_state, updated_state) || won?(updated_state) || draw?(updated_state) ||
      game_on()
  end
end
