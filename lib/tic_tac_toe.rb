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
    reset
  end

  def reset
    @markers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def display_board
    puts " #{@markers[0]} | #{@markers[1]} | #{@markers[2]} "
    puts '---+---+---'
    puts " #{@markers[3]} | #{@markers[4]} | #{@markers[5]} "
    puts '---+---+---'
    puts " #{@markers[6]} | #{@markers[7]} | #{@markers[8]} "
  end

  # https://medium.com/launch-school/number-validation-with-regex-ruby-393954e46797
  def number_string?(str)
    str = str.to_s unless str.is_a? String
    /\A[+-]?\d+(\.\d+)?\z/.match(str)
  end

  def position_free?(position)
    return if %w[X O].include?(@markers[position.to_i])

    true
  end

  def valid_position?(position)
    return unless number_string?(position) && position.size == 1 &&
                  position_free?(position)

    @markers.include?(position.to_i)
  end

  def winner?
    winner = false
    LINES.each do |line|
      if @markers[line[0]] == @markers[line[1]] &&
         @markers[line[0]] == @markers[line[2]]
        winner = true
      end
    end
    winner
  end
end

# Player class
class Player
  @players = []

  class << self
    attr_reader :players
  end

  attr_accessor :marker
  attr_reader :name

  def initialize(marker, name)
    @marker = marker
    @name = name

    self.class.players << self
  end
end


