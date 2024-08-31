defmodule ExTicTacToe.TestHelpers do
  alias ExTicTacToe, as: TTT

  defmacro assert_on_state({:===, _, [l, r]}) do
    quote(bind_quoted: [l: l, r: r]) do
      alias ExTicTacToe.Engine.State
      assert %State{l | journal: nil} === %State{r | journal: nil}
    end
  end

  defmacro assert_on_state({:!==, _, [l, r]}) do
    quote(bind_quoted: [l: l, r: r]) do
      alias ExTicTacToe.Engine.State
      assert %TTT.Engine.State{l | journal: nil} !== %State{r | journal: nil}
    end
  end

  def game_3x3(phase: :new, first: x_or_y) do
    %TTT.Engine.State{
      blank_board: %TTT.Engine.State.Board{
        dimmensions: %{x: 2, y: 2},
        topology:
          MapSet.new([
            %{{0, 0} => nil},
            %{{0, 1} => nil},
            %{{0, 2} => nil},
            %{{1, 0} => nil},
            %{{1, 1} => nil},
            %{{1, 2} => nil},
            %{{2, 0} => nil},
            %{{2, 1} => nil},
            %{{2, 2} => nil}
          ])
      },
      board: %TTT.Engine.State.Board{
        dimmensions: %{x: 2, y: 2},
        topology:
          MapSet.new([
            %{{0, 0} => nil},
            %{{0, 1} => nil},
            %{{0, 2} => nil},
            %{{1, 0} => nil},
            %{{1, 1} => nil},
            %{{1, 2} => nil},
            %{{2, 0} => nil},
            %{{2, 1} => nil},
            %{{2, 2} => nil}
          ])
      },
      next_move: x_or_y,
      journal: [],
      phase: {:game_on, nil},
      turn: 1,
      winning_intersections: %{
        o: [
          MapSet.new([%{{0, 0} => :o}, %{{0, 1} => :o}, %{{0, 2} => :o}]),
          MapSet.new([%{{1, 0} => :o}, %{{1, 1} => :o}, %{{1, 2} => :o}]),
          MapSet.new([%{{2, 0} => :o}, %{{2, 1} => :o}, %{{2, 2} => :o}]),
          MapSet.new([%{{0, 0} => :o}, %{{1, 0} => :o}, %{{2, 0} => :o}]),
          MapSet.new([%{{0, 1} => :o}, %{{1, 1} => :o}, %{{2, 1} => :o}]),
          MapSet.new([%{{0, 2} => :o}, %{{1, 2} => :o}, %{{2, 2} => :o}]),
          MapSet.new([%{{0, 0} => :o}, %{{1, 1} => :o}, %{{2, 2} => :o}]),
          MapSet.new([%{{0, 2} => :o}, %{{1, 1} => :o}, %{{2, 0} => :o}])
        ],
        x: [
          MapSet.new([%{{0, 0} => :x}, %{{0, 1} => :x}, %{{0, 2} => :x}]),
          MapSet.new([%{{1, 0} => :x}, %{{1, 1} => :x}, %{{1, 2} => :x}]),
          MapSet.new([%{{2, 0} => :x}, %{{2, 1} => :x}, %{{2, 2} => :x}]),
          MapSet.new([%{{0, 0} => :x}, %{{1, 0} => :x}, %{{2, 0} => :x}]),
          MapSet.new([%{{0, 1} => :x}, %{{1, 1} => :x}, %{{2, 1} => :x}]),
          MapSet.new([%{{0, 2} => :x}, %{{1, 2} => :x}, %{{2, 2} => :x}]),
          MapSet.new([%{{0, 0} => :x}, %{{1, 1} => :x}, %{{2, 2} => :x}]),
          MapSet.new([%{{0, 2} => :x}, %{{1, 1} => :x}, %{{2, 0} => :x}])
        ]
      }
    }
  end

  def game_2x2(phase: :new, first: x_or_y) do
    %TTT.Engine.State{
      blank_board: %TTT.Engine.State.Board{
        dimmensions: %{x: 1, y: 1},
        topology:
          MapSet.new([
            %{{0, 0} => nil},
            %{{0, 1} => nil},
            %{{1, 0} => nil},
            %{{1, 1} => nil}
          ])
      },
      board: %TTT.Engine.State.Board{
        dimmensions: %{x: 1, y: 1},
        topology:
          MapSet.new([
            %{{0, 0} => nil},
            %{{0, 1} => nil},
            %{{1, 0} => nil},
            %{{1, 1} => nil}
          ])
      },
      next_move: x_or_y,
      journal: [],
      phase: {:game_on, nil},
      turn: 1,
      winning_intersections: %{
        o: [
          MapSet.new([%{{0, 0} => :o}, %{{0, 1} => :o}]),
          MapSet.new([%{{1, 0} => :o}, %{{1, 1} => :o}]),
          MapSet.new([%{{0, 0} => :o}, %{{1, 0} => :o}]),
          MapSet.new([%{{0, 1} => :o}, %{{1, 1} => :o}]),
          MapSet.new([%{{0, 0} => :o}, %{{1, 1} => :o}]),
          MapSet.new([%{{0, 1} => :o}, %{{1, 0} => :o}])
        ],
        x: [
          MapSet.new([%{{0, 0} => :x}, %{{0, 1} => :x}]),
          MapSet.new([%{{1, 0} => :x}, %{{1, 1} => :x}]),
          MapSet.new([%{{0, 0} => :x}, %{{1, 0} => :x}]),
          MapSet.new([%{{0, 1} => :x}, %{{1, 1} => :x}]),
          MapSet.new([%{{0, 0} => :x}, %{{1, 1} => :x}]),
          MapSet.new([%{{0, 1} => :x}, %{{1, 0} => :x}])
        ]
      }
    }
  end

  def game_2x2(phase: :draw) do
    Enum.reduce(
      [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {1, 2}, {0, 2}, {2, 0}, {2, 1}, {2, 2}],
      game_3x3(phase: :new, first: :o),
      fn coords, acc ->
        TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
      end
    )
  end

  def game_2x2(phase: :o_won) do
    Enum.reduce(
      [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {0, 2}],
      game_3x3(phase: :new, first: :o),
      fn coords, acc ->
        TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
      end
    )
  end

  def game_2x2(phase: :x_won) do
    Enum.reduce(
      [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {0, 2}],
      game_3x3(phase: :new, first: :x),
      fn coords, acc ->
        TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
      end
    )
  end

  def game_2x2(phase: :illegal_state) do
    Enum.reduce(
      [{0, 0}, {0, 0}],
      game_3x3(phase: :new, first: :x),
      fn coords, acc ->
        TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
      end
    )
  end

  def game_2x2(phase: :game_on) do
    Enum.reduce(
      [{0, 0}],
      game_3x3(phase: :new, first: :x),
      fn coords, acc ->
        TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
      end
    )
  end
end
