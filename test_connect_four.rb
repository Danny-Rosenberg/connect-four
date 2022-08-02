require "./play_connect_four"


RSpec.describe 'play connect four' do
	let(:player) { Player.new(2) }


	describe '#generate_players' do
		it 'generates new players' do

			players = Game.generate_players(2)

			expect(players[0].id).to eq(1)
			expect(players[1].id).to eq(2)
		end
	end


	describe '#build_grid' do
		it 'builds a grid of Tiles' do
			grid = Grid.new(8, 10).grid

			expect(grid.length).to eq(8)
			expect(grid[0].length).to eq(10)
			expect(grid[0][0].class.name).to eq("Tile")
		end
	end


	describe '#occupy' do
		it 'occupies a tile with a player' do
			tile = Tile.new
			tile.occupy(player)
			expect(tile.occupied?).to be(true)
		end
	end


	describe '#drop_token' do
		it 'drops a token into the bottom row' do
			grid = Grid.new(8, 10)

			expect(grid.grid[0][0].occupied?).to be(false)

			grid.drop_token!(1, player)

			expect(grid.grid[7][1].occupied?).to be(true)

			grid.drop_token!(1, player)
			expect(grid.grid[6][1].occupied?).to be(true)
		end


		it 'raises an exception when dropping out of bounds' do
			grid = Grid.new(8, 10)

			expect { grid.drop_token!(11, player) }.to raise_error(OutOfBoundsError)
		end
	end


	describe '#empty' do
		it 'shows a tile without a player is empty' do
			tile = Tile.new
			expect(tile.empty?).to be(true)
		end
	end


	describe 'Grid' do

		describe '#grid.full?' do
			it 'identifies a full grid' do
				grid = Grid.new(2, 2)
				grid.drop_token!(0, player)
				grid.drop_token!(0, player)
				grid.drop_token!(1, player)

				expect(grid.full?).to be(false)
				grid.drop_token!(1, player)

				expect(grid.full?).to be(true)
			end
		end


		describe '#find_token_row' do
			it 'finds an unoccupied row' do
				grid = Grid.new(8, 10)

				expect(grid.grid[7][0].occupied?).to be(false)
				row = grid.find_token_row(0)
				expect(row).to eq(7)
			end
		end


		describe '#check_horizontally' do
			let(:game) { Game.new(grid_height: 1, grid_width: 10, num_players: 2, play_to: 4) }
			let(:grid) { game.grid }

			it 'looks left and right at the row for connect four' do
				grid.drop_token!(0, player)
			  grid.drop_token!(1, player)
				grid.drop_token!(2, player)
				grid.drop_token!(3, player)

				rules = Rules.new(grid)

				expect(game.check_horizontally(0, 5, player)).to be(false)
				expect(game.check_horizontally(0, 0, player)).to be(true)
				expect(game.check_horizontally(0, 1, player)).to be(true)
			end
		end
	end

end
