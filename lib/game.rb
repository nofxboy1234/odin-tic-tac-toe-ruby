# frozen_string_literal: true

require './lib/player'
require './lib/board'

# Game class
class Game
  def play
    
    play_game = 'y'
    until play_game == 'n'
      Player.reset_players
      Player.new('X', 'Player 1')
      Player.new('O', 'Player 2')
      
      players = Player.players.cycle
      player = players.next
      
      board = Board.new

      until board.winner?
        board.display_board
        puts "Please choose a position (0-8) to place your #{player.marker} marker"
        position = gets.chomp.strip
        next unless board.valid_position?(position)

        board.markers[position.to_i] = player.marker
        player = players.next unless board.winner?
      end

      board.display_board
      puts "\n#{player.name} (#{player.marker}) wins!"

      puts "\nPlay again? (y/n)"
      play_game = gets.chomp.strip
    end
  end
end
