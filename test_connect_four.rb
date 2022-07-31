require "./play_connect_four"

RSpec.describe '#generate_players' do
	it 'generates new players' do
		
		players = Game.generate_players(2)

		expect(players[0].id).to eq(1)
		expect(players[1].id).to eq(2)
	end
end


RSpec.describe '#build_grid' do
	it 'builds a grid of Tiles' do
		grid = Grid.new(8, 10).grid

		expect(grid.length).to eq(8)
		expect(grid[0].length).to eq(10)
		expect(grid[0][0].class.name).to eq("Tile")
	end
end


RSpec.describe '#occupy' do
	it 'occupies a tile with a player' do
		player = Player.new(2)
		tile = Tile.new
		tile.occupy(player)
		expect(tile.occupied?).to be(true)
	end
end


RSpec.describe '#drop_token' do
	it 'drops a token into the bottom row' do
		grid = Grid.new(8, 10)
		player = Player.new(2)

		expect(grid.grid[0][0].occupied?).to be(false)

		grid.drop_token!(1, player)

		expect(grid.grid[7][1].occupied?).to be(true)

		grid.drop_token!(1, player)
		expect(grid.grid[6][1].occupied?).to be(true)
	end
end


RSpec.describe '#empty' do
	it 'shows a tile without a player is empty' do
		tile = Tile.new
		expect(tile.empty?).to be(true)
	end
end


RSpec.describe '#find_token_row' do
	it 'finds an unoccupied row' do
		grid = Grid.new(8, 10)
		player = Player.new(2)

		expect(grid.grid[7][0].occupied?).to be(false)
		row = grid.find_token_row(0)
		expect(row).to eq(7)
	end
end

