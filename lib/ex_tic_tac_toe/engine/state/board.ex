defmodule ExTicTacToe.Engine.State.Board do
  use ExTicTacToe.Engine.State.Board.Access
  use ExTicTacToe.Types

  import ExTicTacToe.Engine.State.Board.Helpers, only: [_generate_fields: 2]

  alias __MODULE__

  defstruct(
    topology: nil,
    dimmensions: nil
  )

  def new(x_max, y_max) when x_max == y_max do
    %Board{
      topology: MapSet.new(_generate_fields(x_max, y_max)),
      dimmensions: %{x: x_max, y: y_max}
    }
  end

  def new(_, _) do
    raise(ArgumentError, "x_max and y_max must be equal, non negative integers")
  end

  def mark(board, x_or_o, {x, y}) when x_or_o in [:x, :o] and is_struct(board, __MODULE__) do
    Access.get_and_update(board, :topology, fn v ->
      {
        v,
        v
        |> MapSet.delete(%{{x, y} => :x})
        |> MapSet.delete(%{{x, y} => :o})
        |> MapSet.delete(%{{x, y} => nil})
        |> MapSet.put(%{{x, y} => x_or_o})
      }
    end)
    |> elem(1)
  end

  def mark(_, _, _) do
    raise(ArgumentError)
  end
end
