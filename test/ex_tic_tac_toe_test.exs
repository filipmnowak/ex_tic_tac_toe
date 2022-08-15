defmodule ExTicTacToeTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe, as: TTT

  @new_game_3x3_x_first %ExTicTacToe.Engine.State{
    blank_board: %ExTicTacToe.Engine.State.Board{
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
    board: %ExTicTacToe.Engine.State.Board{
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

  @new_game_3x3_o_first %ExTicTacToe.Engine.State{
    blank_board: %ExTicTacToe.Engine.State.Board{
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
    board: %ExTicTacToe.Engine.State.Board{
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

  test "test init - base cases" do
    assert TTT.init(2, 2, :x) === @new_game_3x3_x_first
    assert TTT.init(2, 2, :o) != @new_game_3x3_x_first
    assert TTT.init(2, 2, :o) === @new_game_3x3_o_first
    assert TTT.init(2, 2) in [@new_game_3x3_o_first, @new_game_3x3_x_first]
  end
end
