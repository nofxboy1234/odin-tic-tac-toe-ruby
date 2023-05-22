# frozen_string_literal: true

require 'pry-byebug'

# Game board class
class Board
  attr_accessor :markers

  LINES = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize
    @markers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def display_board
    puts " #{markers[0]} | #{markers[1]} | #{markers[2]} "
    print_row_separator
    puts " #{markers[3]} | #{markers[4]} | #{markers[5]} "
    print_row_separator
    puts " #{markers[6]} | #{markers[7]} | #{markers[8]} "
  end

  def valid_position?(position)
    number_string?(position) && markers.include?(position.to_i) &&
      position_free?(position)
  end

  def winner?
    winner = false
    LINES.each do |line|
      if markers[line[0]] == markers[line[1]] &&
         markers[line[0]] == markers[line[2]]
        winner = true
      end
    end
    winner
  end

  private

  def print_row_separator
    puts '---+---+---'
  end

  def number_string?(str)
    str.to_i.to_s == str
  end

  def position_free?(position)
    return false if %w[X O].include?(markers[position.to_i])

    true
  end
end
