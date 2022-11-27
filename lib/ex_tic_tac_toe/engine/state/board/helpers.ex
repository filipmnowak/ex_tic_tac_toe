defmodule ExTicTacToe.Engine.State.Board.Helpers do
  use ExTicTacToe.Types

  import ExTicTacToe.Types.Guards

  @spec _generate_fields(field_x, field_y) :: [field]
  def _generate_fields(x_max, y_max)
      when is_non_neg_integer(x_max) and is_non_neg_integer(y_max) do
    for x <- 0..x_max, y <- 0..y_max, do: %{{x, y} => nil}
  end

  def winning_intersections(x_or_o, {x_max, y_max}) when x_or_o in [:x, :o] do
    _winning_intersections(x_or_o, {x_max, y_max})
  end

  defp _winning_intersections(x_or_o, {x_max, y_max}) do
    [
      for(x <- 0..x_max, y <- 0..y_max, do: %{{x, y} => x_or_o}),
      for(x <- 0..x_max, y <- 0..y_max, do: %{{y, x} => x_or_o}),
      for(x <- 0..x_max, do: %{{x, x} => x_or_o}),
      for(x <- x_max..0, do: %{{x, x_max - x} => x_or_o})
    ]
    |> List.flatten()
    |> Enum.chunk_every(x_max + 1)
    |> Enum.uniq()
    |> Enum.map(fn i -> MapSet.new(i) end)
  end
end
