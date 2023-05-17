# frozen_string_literal: true

require './lib/player'
require './lib/board'

# Game class
class Game
  attr_reader :board

  def initialize
    new_board
  end
  
  def new_board
    @board = Board.new
  end

  def display_board
    board.display_board
  end

  def winner?
    board.winner?
  end

  def play
    play_game = 'y'
    until play_game == 'n'
      Player.reset_players
      Player.new('X', 'Player 1')
      Player.new('O', 'Player 2')

      players = Player.players.cycle
      player = players.next

      new_board

      until winner?
        display_board
        puts "Please choose a position (0-8) to place your #{player.marker} marker"
        position = gets.chomp.strip
        next unless board.valid_position?(position)

        board.markers[position.to_i] = player.marker
        player = players.next unless winner?
      end

      display_board
      puts "\n#{player.name} (#{player.marker}) wins!"

      puts "\nPlay again? (y/n)"
      play_game = gets.chomp.strip
    end
  end
end
