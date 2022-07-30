require "./play_connect_four"

tests = []

test_generate_players = -> do
	players = Game.generate_players(2)

	assert(players[0].id, 1)
	assert(players[1].id, 2)
end


test_build_grid = -> do
	grid = Grid.new(8, 10).grid

	assert(grid.length, 8)
	assert(grid[0].length, 10)
	assert(grid[0][0].class.name, "Tile")
end


test_occupy = -> do
	player = Player.new(2)
	tile = Tile.new
	tile.occupy(player)
	assert(tile.occupied?, true, "check if tile is occupied")
end


test_drop_token = -> do
	grid = Grid.new(8, 10)
	player = Player.new(2)

	assert(grid.grid[0][0].occupied?, false)

	grid.drop_token!(1, player)

	assert(grid.grid[7][1].occupied?, true, "should have token in seventh row, first column")

	grid.drop_token!(1, player)
	assert(grid.grid[6][1].occupied?, true, "should have token in sixth row, first column")
end


test_empty = -> do
	tile = Tile.new
	assert(tile.empty?, true, "tile should be empty")
end


test_find_token_row = -> do
	grid = Grid.new(8, 10)
	player = Player.new(2)

	assert(grid.grid[7][0].occupied?, false)
	row = grid.find_token_row(0)
	assert(row, 7, "should be seventh row")
end

tests.append(test_generate_players)
tests.append(test_build_grid)
tests.append(test_occupy)
tests.append(test_drop_token)
tests.append(test_empty)
tests.append(test_find_token_row)


def assert(obj1, obj2, expectation="")
	if obj1 == obj2
		puts "success!" + " #{expectation}"
	else
		puts "expected #{obj1} to equal #{obj2}" + ": #{expectation}"
	end
end


tests.each do |t|
	t.call
end
