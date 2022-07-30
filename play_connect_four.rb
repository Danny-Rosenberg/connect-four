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
		player = players[players.length % round]

		# game loop
		loop do
			play_turn(grid, player)
			break if game_over?
		end

	end


	#unimplemented
	def play_turn
		return
	end


	def game_over?
		if connect_four?
			puts "player #{player.id} has connect four! Congratulations!"
			true
		elsif grid.full?
			puts "the grid is full, neither player wins."
			true
	  else
			false
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


# x by y grid, also manages the 'dropping' logic
class Grid

	attr_reader :height, :width, :grid

	def initialize(height, width)
		@height = height
		@width  = width
		@grid   = build_grid(height, width)
	end


	def build_grid(h, w)
		Array.new(h) { Array.new(w) { Tile.new } }
	end


	def drop_token!(column, player)
		if column > width || column < 0
			raise StandardError, "must place token within the grid"
		elsif grid[0][column].occupied?
			raise StandardError, "column is already full"
		else
			row = find_token_row(column)
			grid[row][column].occupy(player)
			grid
		end
	end


	def to_s
		grid_string = ""
		(0...grid.length).each do |r|
			grid_string << "\n"
			(0...grid[0].length).each do |c|
				grid_string << grid[r][c].to_s + " "
			end
		end
		grid_string
	end


	def find_token_row(column)
		(height-1).downto(0).each do |i|
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

	def occupy(player)
		@player = player
	end

	def occupied?
		!empty?
	end

	def empty?
		player.nil?
	end

	def to_s
		occupied? ? player.id.to_s : "x"
	end

end
