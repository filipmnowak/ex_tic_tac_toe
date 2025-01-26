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

  # surely, there is a smarter way to do it...
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

  def _field_v_to_glyph(:x), do: "x"
  def _field_v_to_glyph(:o), do: "o"
  def _field_v_to_glyph(nil), do: " "

  def render_board(board) do
    _render_topology(board.topology, board.dimmensions.x + 1) |> List.to_string()
  end

  def _render_topology(topology, size) do
    ["\n"] ++
      for l <- topology |> MapSet.to_list() |> Enum.chunk_every(size) do
        for f <- l do
          [{{_, _}, v}] = Map.to_list(f)
          " " <> _field_v_to_glyph(v) <> " |"
        end ++ ["\n"] ++ [String.duplicate("-", size * 4)] ++ ["\n"]
      end
  end
end
