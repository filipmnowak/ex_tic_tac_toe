defmodule ExTicTacToe.TestHelpers do
  alias ExTicTacToe, as: TTT

  def new_game_3x3_x_first() do
    %TTT.Engine.State{
      blank_board: %TTT.Engine.State.Board{
        dimmensions: %{x: 2, y: 2},
        topology: %{
          __struct__: MapSet,
          version: 2,
          map: %{
            %{{0, 0} => nil} => [],
            %{{0, 1} => nil} => [],
            %{{0, 2} => nil} => [],
            %{{1, 0} => nil} => [],
            %{{1, 1} => nil} => [],
            %{{1, 2} => nil} => [],
            %{{2, 0} => nil} => [],
            %{{2, 1} => nil} => [],
            %{{2, 2} => nil} => []
          }
        }
      },
      board: %TTT.Engine.State.Board{
        dimmensions: %{x: 2, y: 2},
        topology: %{
          __struct__: MapSet,
          version: 2,
          map: %{
            %{{0, 0} => nil} => [],
            %{{0, 1} => nil} => [],
            %{{0, 2} => nil} => [],
            %{{1, 0} => nil} => [],
            %{{1, 1} => nil} => [],
            %{{1, 2} => nil} => [],
            %{{2, 0} => nil} => [],
            %{{2, 1} => nil} => [],
            %{{2, 2} => nil} => []
          }
        }
      },
      next_move: :x,
      phase: {:game_on, nil},
      turn: 1,
      winning_intersections: %{
        o: [
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :o} => [], %{{0, 1} => :o} => [], %{{0, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{1, 0} => :o} => [], %{{1, 1} => :o} => [], %{{1, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{2, 0} => :o} => [], %{{2, 1} => :o} => [], %{{2, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :o} => [], %{{1, 0} => :o} => [], %{{2, 0} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 1} => :o} => [], %{{1, 1} => :o} => [], %{{2, 1} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 2} => :o} => [], %{{1, 2} => :o} => [], %{{2, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :o} => [], %{{1, 1} => :o} => [], %{{2, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 2} => :o} => [], %{{1, 1} => :o} => [], %{{2, 0} => :o} => []}
          }
        ],
        x: [
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :x} => [], %{{0, 1} => :x} => [], %{{0, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{1, 0} => :x} => [], %{{1, 1} => :x} => [], %{{1, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{2, 0} => :x} => [], %{{2, 1} => :x} => [], %{{2, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :x} => [], %{{1, 0} => :x} => [], %{{2, 0} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 1} => :x} => [], %{{1, 1} => :x} => [], %{{2, 1} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 2} => :x} => [], %{{1, 2} => :x} => [], %{{2, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :x} => [], %{{1, 1} => :x} => [], %{{2, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 2} => :x} => [], %{{1, 1} => :x} => [], %{{2, 0} => :x} => []}
          }
        ]
      }
    }
  end

  def new_game_3x3_o_first() do
    %TTT.Engine.State{
      blank_board: %TTT.Engine.State.Board{
        dimmensions: %{x: 2, y: 2},
        topology: %{
          __struct__: MapSet,
          version: 2,
          map: %{
            %{{0, 0} => nil} => [],
            %{{0, 1} => nil} => [],
            %{{0, 2} => nil} => [],
            %{{1, 0} => nil} => [],
            %{{1, 1} => nil} => [],
            %{{1, 2} => nil} => [],
            %{{2, 0} => nil} => [],
            %{{2, 1} => nil} => [],
            %{{2, 2} => nil} => []
          }
        }
      },
      board: %TTT.Engine.State.Board{
        dimmensions: %{x: 2, y: 2},
        topology: %{
          __struct__: MapSet,
          version: 2,
          map: %{
            %{{0, 0} => nil} => [],
            %{{0, 1} => nil} => [],
            %{{0, 2} => nil} => [],
            %{{1, 0} => nil} => [],
            %{{1, 1} => nil} => [],
            %{{1, 2} => nil} => [],
            %{{2, 0} => nil} => [],
            %{{2, 1} => nil} => [],
            %{{2, 2} => nil} => []
          }
        }
      },
      next_move: :o,
      phase: {:game_on, nil},
      turn: 1,
      winning_intersections: %{
        o: [
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :o} => [], %{{0, 1} => :o} => [], %{{0, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{1, 0} => :o} => [], %{{1, 1} => :o} => [], %{{1, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{2, 0} => :o} => [], %{{2, 1} => :o} => [], %{{2, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :o} => [], %{{1, 0} => :o} => [], %{{2, 0} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 1} => :o} => [], %{{1, 1} => :o} => [], %{{2, 1} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 2} => :o} => [], %{{1, 2} => :o} => [], %{{2, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :o} => [], %{{1, 1} => :o} => [], %{{2, 2} => :o} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 2} => :o} => [], %{{1, 1} => :o} => [], %{{2, 0} => :o} => []}
          }
        ],
        x: [
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :x} => [], %{{0, 1} => :x} => [], %{{0, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{1, 0} => :x} => [], %{{1, 1} => :x} => [], %{{1, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{2, 0} => :x} => [], %{{2, 1} => :x} => [], %{{2, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :x} => [], %{{1, 0} => :x} => [], %{{2, 0} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 1} => :x} => [], %{{1, 1} => :x} => [], %{{2, 1} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 2} => :x} => [], %{{1, 2} => :x} => [], %{{2, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 0} => :x} => [], %{{1, 1} => :x} => [], %{{2, 2} => :x} => []}
          },
          %{
            __struct__: MapSet,
            version: 2,
            map: %{%{{0, 2} => :x} => [], %{{1, 1} => :x} => [], %{{2, 0} => :x} => []}
          }
        ]
      }
    }
  end
end
