class Cell
    @x: 0
    @y: 0
    constructor: (xin, yin) ->
        @x = xin
        @y = yin

class Game
    generation: 0
    isFirstGen: true
    gen2: []
    currentGeneration: ->
        if @isFirstGen
            @gen1
        else
            @gen2
    constructor: (@gen1) ->
        
    getXVals: -> cell.x for cell in @currentGeneration()
    getYVals: -> cell.y for cell in @currentGeneration()
    getMaxX: -> Math.max do @getXVals...
    getMaxY: -> Math.max do @getYVals...
    getMinX: -> Math.min do @getXVals...
    getMinY: -> Math.min do @getYVals...
    isN: (origin, cell) ->
        origin.x - 1 <= cell.x <= origin.x + 1 and cell.y is origin.y - 1
    isSide: (origin, cell) ->
        (cell.x is origin.x - 1 or cell.x is origin.x + 1) and cell.y is origin.y
    isS: (origin, cell) ->
        origin.x - 1 <= cell.x <= origin.x + 1 and cell.y is origin.y + 1
    neighbourFilter: (c, cell) -> @isN(cell, c) or @isSide(cell, c) or @isS(cell, c)
             
    getNeighbours: (cell) ->        
        @currentGeneration().filter (c) => @neighbourFilter c, cell

root = exports ? window
root.Cell = Cell
root.Game = Game