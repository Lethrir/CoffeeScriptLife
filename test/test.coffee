{Cell, Game} = require '../src/life'
assert = require 'assert'

describe 'Cell', ->
    it 'should exist', ->
        cell = new Cell
        if not cell?
            assert.fail 'Cell was not created'
    it 'should contain x position', ->
        cell = new Cell 1,0
        assert.equal cell.x, 1
    it 'should contain y position', ->
        cell = new Cell 0,1
        assert.equal cell.y, 1

describe 'Game', ->
    # setup some cells and a game to use throughout the tests
    cell1 = new Cell 20,3
    cell2 = new Cell 1,60
    cell3 = new Cell 8,8
    cell4 = new Cell 8,9
    cell5 = new Cell 7,7
    game = new Game [cell1, cell2, cell3, cell4, cell5]
    it 'should exist', ->
        if not game?
            assert.fail 'Game was not created'
    it 'should have 2 cells', ->
        assert.equal 5, game.gen1.length
    it 'should have first cell 20, 3', ->
        assert.equal game.gen1[0].x, 20
        assert.equal game.gen1[0].y, 3
    it 'should have second cell 1, 60', ->
        assert.equal game.gen1[1].x, 1
        assert.equal game.gen1[1].y, 60
    it 'should get max x', ->
        assert.equal game.getMaxX(), 20
    it 'should get max y', ->
        assert.equal do game.getMaxY, 60
    it 'should get min x', ->
        assert.equal do game.getMinX, 1
    it 'should get min y', ->
        assert.equal do game.getMinY, 3
    it 'should find no neighbours', ->
        neighbours = game.getNeighbours cell1
        assert.equal 0, neighbours.length
    it 'should find 1 neighbour', ->
        neighbours = game.getNeighbours cell5
        assert.equal 1, neighbours.length
    it 'should find 2 neighbours', ->
        neighbours = game.getNeighbours cell3
        assert.equal 2, neighbours.length