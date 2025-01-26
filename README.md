# ExTicTacToe

Verbose and non-idiomatic exercise in futility: `MapSet`-based [Tic-tac-toe](https://en.wikipedia.org/wiki/Tic-tac-toe) implementation, with variable game board size. (Though not optimized for bigger boards sizes.)

## TODO

- ~~Set draw when it's draw.~~
- ~~Illegal state not being communicated via API (currently: silent NOOP).~~
- Tests are utter mess.
- Leaky state checks.
- Leaky init/new state API (reject invalid x and y values).
- OTP app usage example.
- Function annotations.

## Installation

The package can be installed
by adding `ex_tic_tac_toe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_tic_tac_toe, "~> 0.2.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_tic_tac_toe](https://hexdocs.pm/ex_tic_tac_toe).

## Examples

### Draw

```elixir
iex> alias ExTicTacToe, as: TTT
iex> ttt = Enum.reduce(
...>    [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {1, 2}, {0, 2}, {2, 0}, {2, 1}, {2, 2}],
...>    TTT.init(2, 2),
...>    fn coords, acc ->
...>      TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
...>    end
...> )
%ExTicTacToe.Engine.State{...}
iex> TTT.phase(ttt) === {:draw, nil}
true
iex> TTT.Engine.State.Board.Helpers.render_board(ttt.board) |> IO.puts()

 x | x | o |
------------
 o | o | x |
------------
 x | o | x |
------------

:ok
```

### Win

```elixir
iex> alias ExTicTacToe, as: TTT
iex> ttt = Enum.reduce(
...>   [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {0, 2}],
...>   TTT.init(2, 2, :x),
...>   fn coords, acc ->
...>     TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
...>   end
...> )
%ExTicTacToe.Engine.State{...}
iex> TTT.phase(ttt) === {:won, :x}
true
iex> TTT.Engine.State.Board.Helpers.render_board(ttt.board) |> IO.puts()

 x | x | x |
------------
 o | o |   |
------------
   |   |   |
------------

:ok
```

### Illegal move

```elixir
iex> alias ExTicTacToe, as: TTT
iex> ttt = Enum.reduce(
...>   [{0, 0}, {0, 0}],
...>   TTT.init(2, 2),
...>   fn coords, acc ->
...>     TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
...>   end
...> )
%ExTicTacToe.Engine.State{...}
iex> TTT.phase(ttt) === {:illegal_state, nil}
true
iex> TTT.Engine.State.Board.Helpers.render_board(ttt.board) |> IO.puts()

 o |   |   |
------------
   |   |   |
------------
   |   |   |
------------

:ok
```
