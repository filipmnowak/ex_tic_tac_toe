defmodule ExTicTacToe.Types do
  defmacro __using__(_opts) do
    quote do
      @type x_or_o :: :x | :o
      @type field_coord :: non_neg_integer()
      @type field_x :: field_coord()
      @type field_y :: field_coord()
      @type field :: %{{field_x(), field_y()} => nil | x_or_o()}
    end
  end
end
