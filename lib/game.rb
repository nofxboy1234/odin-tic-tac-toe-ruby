# frozen_string_literal: true

require './lib/player'
require './lib/board'

# Game class
class Game
  attr_reader :board, :player

  def input_position
    position = '-1'
    until board.valid_position?(position)
      puts "Please choose a position (0-8) to place your #{player_marker} marker"
      position = player_input
    end
    position
  end

  def game_loop
    until game_over?
      next_player
      display_board

      board.update_marker(input_position.to_i, player_marker)
    end
  end

  def show_win_screen
    display_board

    if board.winner?
      puts "\n#{player.name} (#{player_marker}) wins!"
    else
      puts 'The game is tied!'
    end

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

  def next_player
    @player = players.next
  end

  def display_board
    board.display_board
  end
  
  def player_marker
    player.marker
  end

  def game_over?
    winner? || board.full?
  end

  def reset_players
    @players = nil
    Player.reset_players
    Player.new('X', 'Player 1')
    Player.new('O', 'Player 2')
  end

  def new_board
    @board = Board.new
  end

  private

  def players
    @players ||= Player.players.cycle
  end

  def winner?
    board.winner?
  end

  def player_input
    gets.chomp.strip
  end


end
