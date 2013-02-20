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
        if @generation % 2 is 0
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

    cellBorn: (cell) ->
        @getNeighbours(cell) is 3
    cellOverpopulated: (cell) ->
        @getNeighbours cell > 3
    cellUnderpopulated: (cell) ->
        @getNeighbours cell < 2
    cellLives: (cell) ->
        2 <= @getNeighbours(cell) <= 3 and (@currentGeneration().filter (c) -> c.x is cell.x and c.y is cell.y).length is 1

    checkCell: (cell) ->
        not (@cellUnderpopulated cell or @cellOverpopulated cell)

    doGeneration: ->
        thisGen = @currentGeneration
        nextGen = []

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