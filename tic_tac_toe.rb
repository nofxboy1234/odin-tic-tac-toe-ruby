# frozen_string_literal: true

require 'pry-byebug'

# Game board class
class Board
  attr_accessor :board_markers

  LINES = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

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

  def winner?
    # binding.pry

    winner = false
    LINES.each do |line|
      if @board_markers[line[0]] == @board_markers[line[1]] && @board_markers[line[0]] == @board_markers[line[2]]
        winner = true
      end
    end
    winner
  end
end

# Player class
class Player
  @@players = []
  @count = 0

  attr_accessor :marker
  attr_reader :name

  def initialize(marker, name)
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

  def self.players
    @@players
  end

  class << self
    attr_reader :count
  end

  class << self
    attr_writer :count
  end
end

board = Board.new

Player.new('X', 'Player 1')
Player.new('O', 'Player 2')
players = Player.players.cycle

until board.winner?
  player = players.next
  puts "Please choose a position to place your #{player.marker} marker"
  position = gets.chomp.to_i
  puts "You chose position #{position}"
  board.board_markers[position] = player.marker
  board.display_board
end

puts "#{player.name} (#{player.marker}) wins!"
