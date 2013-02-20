{Cell, Game} = require 'life'

outputLife = (game) ->
    for y in game.getYRange()
        out = ''
        for x in game.getXRange()
            if game.isLive(new Cell x,y)
                out += 'X'
            else
                out += ' '
        console.log out
    console.log 'END GENERATION'

cell1 = new Cell 1,1
cell2 = new Cell 1,2
cell3 = new Cell 2,2
cell4 = new Cell 2,1

game = new Game [cell1, cell2, cell3, cell4]
outputLife(game)
game.doGeneration()
outputLife(game)
game.doGeneration()
outputLife(game)