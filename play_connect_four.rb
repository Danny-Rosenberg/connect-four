# players alternate dropping tokens in a fixed-size grid
# first player to get four tokens in a row, wins
# "four in a row" can mean vertically, horizontally, or diagonally
#
# Because you're 'dropping' tokens, you can only choose the column, you can't choose the row
# Must be testable, viewable, playable


# runs the game, player input, initiates turns
class Game

	attr_reader :grid, :round_num, :player_turn, :players

	# define size of board
	def initialize(grid_height, grid_width, num_players=2)
		@grid      = setup_grid(grid_height, grid_width)
		@round_num = 1
		@players   = generate_players(num_players)
	end


	# main driver function
	def play_game
		not_finished = false
		player = players[players.length % round]

		# game loop
		while not_finished
			not_finished = play_turn(grid, player)
		end

	end


private


	def setup_grid(height, width)
		Grid.new(height, width)
	end

	
	def self.generate_players(num_players)
		(1..num_players).to_a.map { |id| Player.new(id) }
	end

end


class Player

	attr_reader :id

	def initialize(id)
		@id = id
	end

end


# orchestrates a single turn, probably just for a single player
class Turn

end


# x by y grid, maybe also manages the 'dropping' logic
class Grid

	attr_reader :height, :width, :grid

	def initialize(height, width)
		@height = height
		@width  = width
		@grid   = build_grid
	end


	private


	def self.build_grid(h, w)
		Array.new(h) { Array.new(w) { Tile.new } }
	end


	def drop_token!(column, player_id)
		if column > width || column < 1
			raise StandardError, "must place token within the grid"
		elsif grid[height-1][column-1].occupied?
			raise StandardError, "column is already full"
		else
			row = find_token_row(column)
			grid[row][column].occupy(player_id)
			grid
		end
	end


	def to_s
		grid_string = ""
		(0...grid.length).each do |r|
			grid_string << "\n"
			(0...grid[0].length).each do |c|
				grid_string << grid[r][c].to_s
			end
		end
	end


	private

	def find_token_row(column)
		(0...height).each do |i|
			return i if grid[i][column].empty?
		end
	end

end


# represents a single spot in the grid, if it has a token or not, whose token
class Tile

	attr_reader :player

	def initialize
		@player = nil
	end

	def occupied?
		player.nil?
	end

	def empty?
		!occupied?
	end

	def to_s
		occupied? ? played.id : "x"
	end

end
