# Yen168@Github
# buggy.....just for fun


class Board

	MAP_H = 3
	MAP_W = 3
	MAP_C = {

		1=>[0,0],2=>[0,1],3=>[0,2],
		4=>[1,0],5=>[1,1],6=>[1,2],
		7=>[2,0],8=>[2,1],9=>[2,2]

	}

	def initialize

		@map = Array.new(MAP_H){Array.new(MAP_W){"#"}}

	end

	def check(maker)

		(0..2).each do |i|
			if (@map[i][0] == @map[i][1] && @map[i][1] == @map[i][2]) && @map[i][1] == maker 

		 	  return true 

		 	elsif (@map[0][i] == @map[1][i] && @map[1][i] == @map[2][i]) && @map[1][i] == maker

		 	  return true
  
			end
		end

		if ((@map[0][0] == @map[1][1] && @map[1][1] == @map[2][2])||
			 (@map[2][0] == @map[1][1] && @map[1][1] == @map[0][2])) && @map[1][1] == maker
				return true
		else
			false
		end

	end

	def draw

		@map.map.with_index{|x| p x}

	end

	def mark(player)

		succ = 0

		@first = player.input ||= "undef"

		x, y = MAP_C.fetch(player.input,"error")
		return "error" if x == "error"
		
		if @map[x][y]== "#"

			@map[x][y]= player.maker

			puts "marked"

			if self.check(player.maker)

				puts "\n\n*** The winner is #{player.name}! ***\n\n"
				return true

			end

		else

			puts "Chose. Try again!"
			player.choose

		end
		false
	end

end

class Player

	attr_reader :maker, :input, :name

	def initialize(name,maker)
		@name = name
		@maker = maker
	end

	def choose
		puts "\n#{self.name}'s' turn"
		print "Choose from: \n[1][2][3]\n[4][5][6]\n[7][8][9]\n(exit: e):"
		@input = gets.chomp

		if (1..9).include? @input.to_i
			
			return @input = @input.to_i
		
		elsif @input == "e"

			"exit"
			
		else
			puts "Please select again! (1 to 9)"
			self.choose
		end

	end


end

board = Board.new
p1 = Player.new("Yen","O")
p2 = Player.new("David","X")
players = [p1,p2]
game_over = false

loop do

	break if game_over == true

	players.each do |player|

	 board.draw
	 break if game_over = (player.choose == "exit")
	 break if game_over = (board.mark(player))
	
	end


end

puts "Have a nice game agan!"
