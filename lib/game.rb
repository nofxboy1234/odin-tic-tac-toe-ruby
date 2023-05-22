# frozen_string_literal: true

require './lib/player'
require './lib/board'

require 'pry-byebug'

# Game class
class Game
  attr_reader :board, :player

  def input_position
    puts "Please choose a position (0-8) to place your #{player_marker} marker"
    player_input
  end

  def game_loop
    until winner?
      display_board

      position = input_position
      next unless board.valid_position?(position)

      board.update_marker(position.to_i, player_marker)
      # board.markers[position.to_i] = player_marker
      @player = next_player unless winner?
    end
  end

  def show_win_screen
    display_board
    puts "\n#{player.name} (#{player_marker}) wins!"
    puts "\nPlay again? (y/n)"
    player_input
  end

  def play
    play_game = 'y'
    until play_game == 'n'
      reset_players
      new_board

      game_loop

      play_game = show_win_screen
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
