# ExTicTacToe


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
