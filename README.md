# ExTicTacToe

Verbose and non-idiomatic exercise in futility: `MapSet`-based [Tic-tac-toe](https://en.wikipedia.org/wiki/Tic-tac-toe) implementation, with variable game board size. (Though not optimized for bigger boards sizes.)

## TODO

- ~Set draw when it's draw.~
- ~Illegal state not being communicated via API (currently: silent NOOP).~
- Tests.
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
iex> Enum.reduce(
...>   [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {1, 2}, {0, 2}, {2, 0}, {2, 1}, {2, 2}],
...>   TTT.init(2, 2),
...>   fn coords, acc ->
...>     TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
...>   end
...> )

iex> TTT.phase(y) === {:draw, nil}
true

# x | o | x
#-----------
# x | o | o
#-----------
# o | x | x
```

### Win

```elixir
iex> Enum.reduce(
...>   [{0, 0}, {1, 0}, {0, 1}, {1, 1}, {0, 2}],
...>   TTT.init(2, 2),
...>   fn coords, acc ->
...>     TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
...>   end
...> )

iex> TTT.phase(y) === {:won, :o}
true

# x | o |
#-----------
# x | o |
#-----------
# x |   |
```

### Illegal move

```elixir
iex> Enum.reduce(
...>   [{0, 0}, {0, 0}],
...>   TTT.init(2, 2),
...>   fn coords, acc ->
...>     TTT.progress_game(acc, TTT.mark(acc, acc.next_move, coords))
...>   end
...> )

iex> TTT.phase(y) === {:illegal_move, nil}
true

# o |   |
#-----------
#   |   |
#-----------
#   |   |
```
