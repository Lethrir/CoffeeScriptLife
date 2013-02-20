class Cell
    @x: 0
    @y: 0
    constructor: (xin, yin) ->
        @x = xin
        @y = yin

class Game
    generation: 0
    gen2: []

    clearNextGeneration: () ->
        if @generation % 2 is 1
            @gen1 = []
        else
            @gen2 = []

    setGeneration: (cells) ->
        if @generation % 2 is 1
            @gen1 = cells
        else
            @gen2 = cells

    getGeneration: (i) ->
        if @generation % 2 is i
            @gen1
        else
            @gen2
    currentGeneration: -> @getGeneration 0
    nextGeneration: -> @getGeneration 1
    constructor: (@gen1) ->
        
    getXVals: -> cell.x for cell in @currentGeneration()
    getYVals: -> cell.y for cell in @currentGeneration()
    getMaxX: -> Math.max do @getXVals...
    getMaxY: -> Math.max do @getYVals...
    getMinX: -> Math.min do @getXVals...
    getMinY: -> Math.min do @getYVals...
    getXRange: -> [(@getMinX()-1)..(@getMaxX()+1)]
    getYRange: -> [(@getMinY()-1)..(@getMaxY()+1)]
    isN: (origin, cell) ->
        origin.x - 1 <= cell.x <= origin.x + 1 and cell.y is origin.y - 1
    isSide: (origin, cell) ->
        (cell.x is origin.x - 1 or cell.x is origin.x + 1) and cell.y is origin.y
    isS: (origin, cell) ->
        origin.x - 1 <= cell.x <= origin.x + 1 and cell.y is origin.y + 1
    neighbourFilter: (c, cell) -> @isN(cell, c) or @isSide(cell, c) or @isS(cell, c)
             
    getNeighbours: (cell) ->        
        @currentGeneration().filter (c) => @neighbourFilter c, cell

    isLive: (cell) ->
        (@currentGeneration().filter (c) -> c.x is cell.x and c.y is cell.y).length is 1

    cellBorn: (cell) ->
        @getNeighbours(cell).length is 3
    cellOverpopulated: (cell) ->
        @getNeighbours(cell).length > 3
    cellUnderpopulated: (cell) ->
        @getNeighbours(cell).length < 2
    cellLives: (cell) ->
        2 <= @getNeighbours(cell).length <= 3 and @isLive(cell)

    checkCell: (cell) ->
        not (@cellUnderpopulated cell or @cellOverpopulated cell)

    doGeneration: ->
        thisGen = @currentGeneration()
        nextGen = []

        if thisGen.length > 0
            for x in @getXRange()
                for y in @getYRange()
                    cell = new Cell x,y                
                    if @cellBorn(cell) or @cellLives(cell)
                        nextGen.push cell

        @setGeneration nextGen
        @generation = @generation + 1
        nextGen
        
root = exports ? window
root.Cell = Cell
root.Game = Game

outputLife = (game) ->
    if game.currentGeneration().length > 0
        for y in game.getYRange()
            out = ''
            for x in game.getXRange()
                if game.isLive(new Cell x,y)
                    out += 'X'
                else
                    out += ' '
            console.log out
    console.log 'GENERATION ' + game.generation + ' live cells ' + game.currentGeneration().length

cell11 = new Cell 1,1
cell12 = new Cell 1,2
cell13 = new Cell 1,3
cell16 = new Cell 1,6

cell21 = new Cell 2,1
cell22 = new Cell 2,2
cell23 = new Cell 2,3

cell31 = new Cell 3,1
cell32 = new Cell 3,2
cell33 = new Cell 3,3
cell34 = new Cell 3,4
cell35 = new Cell 3,5
cell36 = new Cell 3,6

cell42 = new Cell 4,2
cell43 = new Cell 4,3

cell52 = new Cell 5,2
cell53 = new Cell 5,3
cell54 = new Cell 5,4

cell63 = new Cell 6,3

cell71 = new Cell 7,1
cell72 = new Cell 7,2
cell73 = new Cell 7,3

cell82 = new Cell 8,2
cell83 = new Cell 8,3

block = [cell11, cell12, cell22, cell21]
blinker = [cell11, cell12, cell13]
loaf = [cell21, cell31, cell42, cell43, cell34, cell23, cell12]
glider = [cell21, cell32, cell33, cell23, cell13]
infiniteGrowth = [cell16, cell36, cell35, cell54, cell53, cell52, cell73, cell72, cell71, cell82]
dieHard = [cell12, cell22, cell23, cell71, cell63, cell73, cell83]

game = new Game dieHard
outputLife(game)
for i in [1..130]
    game.doGeneration()
    outputLife(game)
console.log 'Done!'