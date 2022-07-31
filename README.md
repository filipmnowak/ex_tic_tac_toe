# ExTicTacToe

verbose and non-idiomatic exercise in futility: `MapSet`-based [Tic-tac-toe](https://en.wikipedia.org/wiki/Tic-tac-toe) implementation, with variable game board size.

## TODO

- tests.
- leaky state checks.
- leaky init/new state API (reject invalid x and y values).
- OTP app usage example.
- function annotations.

## Installation

The package can be installed
by adding `ex_tic_tac_toe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_tic_tac_toe, "~> 0.1.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_tic_tac_toe](https://hexdocs.pm/ex_tic_tac_toe).

## Example

```elixir
alias ExTicTacToe.Engine
#   |   |
#-----------
#   |   |
#-----------
#   |   |
game = Engine.init(2, 2)
updated_game = Engine.mark(game, game.next_move, {0, 0})
# x |   |
#-----------
#   |   |
#-----------
#   |   |
game = Engine.progress_game(game, updated_game)
updated_game = Engine.mark(game, game.next_move, {1, 0})
# x | o |
#-----------
#   |   |
#-----------
#   |   |
game = Engine.progress_game(game, updated_game)
updated_game = Engine.mark(game, game.next_move, {0, 1})
# x | o |
#-----------
# x |   |
#-----------
#   |   |
game = Engine.progress_game(game, updated_game)
updated_game = Engine.mark(game, game.next_move, {1, 1})
# x | o |
#-----------
# x | o |
#-----------
#   |   |
game = Engine.progress_game(game, updated_game)
updated_game = Engine.mark(game, game.next_move, {0, 2})
# x | o |
#-----------
# x | o |
#-----------
# x |   |
game = Engine.progress_game(game, updated_game)
```
