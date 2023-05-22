# frozen_string_literal: true

require './lib/player'
require './lib/board'

require 'pry-byebug'

# Game class
class Game
  attr_reader :board, :player

  def play
    play_game = 'y'
    until play_game == 'n'
      reset_players
      new_board

      until winner?
        display_board
        puts "Please choose a position (0-8) to place your #{player_marker} marker"
        position = player_input
        next unless board.valid_position?(position)

        board.markers[position.to_i] = player_marker
        @player = next_player unless winner?
      end

      display_board
      puts "\n#{player.name} (#{player_marker}) wins!"

      puts "\nPlay again? (y/n)"
      play_game = player_input
    end
  end

  private

  def new_board
    @board = Board.new
  end

  def players
    @players ||= Player.players.cycle
  end

  def display_board
    board.display_board
  end

  def winner?
    board.winner?
  end

  def player_input
    gets.chomp.strip
  end

  def player_marker
    player.marker
  end

  def next_player
    # binding.pry
    players.next
  end

  def reset_players
    Player.reset_players
    Player.new('X', 'Player 1')
    Player.new('O', 'Player 2')

    @player = next_player
  end
end
