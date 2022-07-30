require "./play_connect_four"

tests = []

test_generate_players = -> do
	players = Game.generate_players(2)

	assert(players[0].id, 1)
	assert(players[1].id, 2)
end


test_build_grid = -> do
	grid = Grid.build_grid(8, 10)

	assert(grid.length, 8)
	assert(grid[0].length, 10)
	assert(grid[0][0].class.name, "Tile")
end

test_drop_token = -> do
	grid = Grid.build_grid(8, 10)

	assert(grid[0][0].occupied?, false)
end

tests.append(test_generate_players)
tests.append(test_build_grid)
tests.append(test_drop_token)

def assert(obj1, obj2, expectation="")
	if obj1 == obj2
		puts "success!" + " #{expectation}"
	else
		puts "expected #{obj1} to equal #{obj2}"
	end
end


tests.each do |t|
	t.call
end
