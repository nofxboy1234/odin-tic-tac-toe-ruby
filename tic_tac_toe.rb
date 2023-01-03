# frozen_string_literal: true

# Game board class
class Board
  def initialize
    puts ' 0 | 1 | 2 '
    puts '---+---+---'
    puts ' 3 | 4 | 5 '
    puts '---+---+---'
    puts ' 6 | 7 | 8 '
  end
end

require 'pry-byebug'

# Player class
class Player
  @@players = []
  def initialize(marker, name)
    # binding.pry
    @marker = marker
    @name = name
    @@players << self
    # p @@players
  end

  def self.show_players
    p @@players
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
# Display board
# Check if there's a winning line

# Ask player 2 for a position to place marker
# Display board
# Check if there's a winning line
