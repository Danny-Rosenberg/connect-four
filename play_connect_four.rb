# players alternate dropping tokens in a fixed-size grid
# first player to get four tokens in a row, wins
# "four in a row" can mean vertically, horizontally, or diagonally
#
# Because you're 'dropping' tokens, you can only choose the column, you can't choose the row
# Must be testable, viewable, playable


# runs the game, player input, initiates turns
# for future, could make 'connect four' value variable (i.e. get 5 in a row, or 7 in a row to win)
class Game

	attr_reader :grid, :round_num, :player_turn, :players, :turn

	# define size of board
	def initialize(grid_height:, grid_width:, num_players: 2, play_to: 4)
		@grid      = Grid.new(grid_height, grid_width)
		@round_num = 1
		@players   = Game.generate_players(num_players)
		@turn      = nil
		@rules     = Rules.new(4)
	end


	# main driver function
	def play_game
		player = players[players.length % round_num]

		# game loop
		loop do
			@turn = play_turn(grid, player)
			break if game_over?(turn)
			round += 1
		end

	end


	# unimplemented
	# returns the row and column of the last dropped token
	def play_turn
		# gather input
		# create Turn object out of input
		return
	end


	def game_over?
		if connect_four?(row, column, player)
			puts "player #{player.id} has connect four! Congratulations!"
			true
		elsif grid.full?
			puts "the grid is full, neither player wins."
			true
	  else
			false
		end
	end


	# looks for four in a row tokens horizontally, vertically, and diagonally
	# uses the most recently dropped token as a starting point
	def connect_four?(row, column, player)
		check_horizontally(row, column, player) ||
			check_vertically(row, column, player) ||
			check_diagonally(row, column, player)
	end


	# TODO makes this a instance method
	def self.generate_players(num_players)
		(1..num_players).to_a.map { |id| Player.new(id) }
	end


	def check_horizontally(row, column, player, play_to=4)
		left = [column - play_to + 1, 0].max
		right = [column + play_to - 1, grid.width-1].min
	
		max_consec = 0
		left.upto(right).each do |c|
			max_consec = grid.grid[row][c].player == player ? max_consec + 1 : 0
			if max_consec == play_to
				return true
			end
		end
		false
	end

end


class Rules

	attr_reader :play_to

	def initialize(play_to=4)
		@play_to = play_to
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

	attr_reader :current_player, :chosen_row, :chosen_column

	def initialize(current_player)
		@player 			 = player
		@chosen_row    = nil
		@chosen_column = nil
	end

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
			raise OutOfBoundsError, "must place token within the grid"
		elsif grid[0][column].occupied?
			raise ColumnFullError, "column is already full"
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


	def full?
		(0...height).each do |r|
			(0...width).each do |c|
				return false if grid[r][c].empty?
			end
		end
		true
	end

end

class OutOfBoundsError < StandardError; end
class ColumnFullError < StandardError; end

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
