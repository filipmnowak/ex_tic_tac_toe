defmodule ExTicTacToe.Engine.State.Board.Access do
  defmacro __using__(_opt) do
    quote do
      @behaviour Access
      @impl Access
      def fetch(struct, key) do
        Map.fetch(struct, key)
      end

      @impl Access
      def get_and_update(struct, key, fun) do
        Map.get_and_update(struct, key, fun)
      end

      @impl Access
      def pop(struct, key, default \\ nil) do
        Map.pop(struct, key, default)
      end
    end
  end
end
