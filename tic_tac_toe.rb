# frozen_string_literal: true

require 'pry-byebug'

# Game board class
class Board
  attr_accessor :board_markers

  def initialize
    @board_markers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    display_board
  end

  def display_board
    puts " #{@board_markers[0]} | #{@board_markers[1]} | #{@board_markers[2]} "
    puts '---+---+---'
    puts " #{@board_markers[3]} | #{@board_markers[4]} | #{@board_markers[5]} "
    puts '---+---+---'
    puts " #{@board_markers[6]} | #{@board_markers[7]} | #{@board_markers[8]} "
  end
end

# Player class
class Player
  @@players = []
  @count = 0

  def initialize(marker, name)
    # binding.pry
    @marker = marker
    @name = name
    @@players << self
    self.class.count += 1
    # p @@players
  end

  def self.show_players
    p @@players
    p @count
  end

  class << self
    attr_reader :count
  end

  class << self
    attr_writer :count
  end
end

# create board
board = Board.new

# display board:
#  0 | 1 | 2
# ---+---+---
#  3 | 4 | 5
# ---+---+---
#  6 | 7 | 8
# ---+---+---

# create player 1 - 'X'
player_one = Player.new('X', 'Player 1')
# create player 2 - 'O'
player_two = Player.new('O', 'Player 2')
Player.show_players

# While no winning line:
# Ask player 1 for a position to place marker
puts 'Please choose a position to place your X marker'
position = gets.chomp
puts "You chose position #{position}"
# Display board with marker

# Check if there's a winning line

# Ask player 2 for a position to place marker
# Display board with marker
# Check if there's a winning line
