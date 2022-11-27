Code.require_file("../test_helpers.exs", __DIR__)

defmodule ExTicTacToe.Engine.StateTest do
  use ExUnit.Case
  doctest ExTicTacToe

  alias ExTicTacToe.Engine, as: Eng
  alias ExTicTacToe.Engine.State
  require State
  import ExTicTacToe.TestHelpers

  test "State.x_won/0" do
    assert State.x_won() === {:won, :x}
  end

  test "State.o_won/0" do
    assert State.o_won() === {:won, :o}
  end

  test "State.draw/0" do
    assert State.draw() === {:draw, nil}
  end

  test "State.game_on/0" do
    assert State.game_on() === {:game_on, nil}
  end

  test "State.illegal_state/0" do
    assert State.illegal_state() === {:illegal_state, nil}
  end

  test "State.repeat_turn/1" do
    assert State.repeat_turn(:x) === :x
    assert State.repeat_turn(:o) === :o
  end

  test "State.whos_turn?/0" do
    assert State.whos_turn?() in [:x, :o]
  end

  test "State.whos_turn?/1" do
    assert State.whos_turn?(:o) === :x
    assert State.whos_turn?(:x) === :o
  end

  test "State.new/2" do
    assert(
      State.new(0, 0) ===
        %ExTicTacToe.Engine.State{
          winning_intersections: %{
            o: [MapSet.new([%{{0, 0} => :o}])],
            x: [MapSet.new([%{{0, 0} => :x}])]
          },
          phase: :init,
          turn: nil,
          next_move: nil,
          board: %ExTicTacToe.Engine.State.Board{
            topology: MapSet.new([%{{0, 0} => nil}]),
            dimmensions: %{x: 0, y: 0}
          },
          blank_board: %ExTicTacToe.Engine.State.Board{
            topology: MapSet.new([%{{0, 0} => nil}]),
            dimmensions: %{x: 0, y: 0}
          }
        }
    )
  end

  test "State.mark/3" do
    assert State.mark(game_3x3(phase: :new, first: :x), :x, {0, 0}).board.topology ===
             MapSet.new([
               %{{0, 0} => :x},
               %{{0, 1} => nil},
               %{{0, 2} => nil},
               %{{1, 0} => nil},
               %{{1, 1} => nil},
               %{{1, 2} => nil},
               %{{2, 0} => nil},
               %{{2, 1} => nil},
               %{{2, 2} => nil}
             ])

    assert State.mark(game_3x3(phase: :new, first: :o), :o, {0, 1}).board.topology ===
             MapSet.new([
               %{{0, 0} => nil},
               %{{0, 1} => :o},
               %{{0, 2} => nil},
               %{{1, 0} => nil},
               %{{1, 1} => nil},
               %{{1, 2} => nil},
               %{{2, 0} => nil},
               %{{2, 1} => nil},
               %{{2, 2} => nil}
             ])
  end

  test "State.mark/3 - bad arg" do
    assert_raise ArgumentError, fn -> State.mark(game_3x3(phase: :new, first: :o), :z, {0, 1}) end
  end

  test "State.won?/1 - won" do
    assert game_2x2(phase: :x_won) |> State.won?() === State.x_won()
    assert game_2x2(phase: :o_won) |> State.won?() === State.o_won()
  end

  test "State.won?/1 - no win" do
    assert game_2x2(phase: :draw) |> State.won?() === false
    assert game_2x2(phase: :game_on) |> State.won?() === false
    assert game_2x2(phase: :illegal_state) |> State.won?() === false
  end

  test "State.draw?/1 - draw" do
    assert game_2x2(phase: :draw) |> State.draw?() === State.draw()
  end

  test "State.draw?/1 - no draw" do
    assert game_2x2(phase: :x_won) |> State.draw?() === false
    assert game_2x2(phase: :o_won) |> State.draw?() === false
    assert game_2x2(phase: :game_on) |> State.draw?() === false
    assert game_2x2(phase: :illegal_state) |> State.draw?() === false
  end

  test "State.illegal?/1 - illegal transitions" do
    game =
      Enum.reduce(
        [{0, 0}],
        game_3x3(phase: :new, first: :x),
        fn coords, acc ->
          Eng.progress_game(acc, State.mark(acc, acc.next_move, coords))
        end
      )

    assert State.illegal?(game, game) === State.illegal_state()

    assert State.illegal?(game, State.mark(game, :o, {0, 0})) === State.illegal_state()

    assert State.illegal?(game, State.mark(game, :x, {1000, 0})) === State.illegal_state()

    assert State.illegal?(State.mark(game, :x, {1, 0}), game) === State.illegal_state()

    assert State.illegal?(game, State.mark(game, :x, {0, 1}) |> State.mark(:x, {0, 2})) ===
             State.illegal_state()
  end
end
