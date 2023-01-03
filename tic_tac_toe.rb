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
    reset
    # display_board
  end

  def reset
    @board_markers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def display_board
    puts " #{@board_markers[0]} | #{@board_markers[1]} | #{@board_markers[2]} "
    puts '---+---+---'
    puts " #{@board_markers[3]} | #{@board_markers[4]} | #{@board_markers[5]} "
    puts '---+---+---'
    puts " #{@board_markers[6]} | #{@board_markers[7]} | #{@board_markers[8]} "
  end

  # https://medium.com/launch-school/number-validation-with-regex-ruby-393954e46797
  def number?(obj)
    obj = obj.to_s unless obj.is_a? String
    /\A[+-]?\d+(\.\d+)?\z/.match(obj)
  end

  def valid_position?(position)
    return unless number?(position) && position.size == 1 &&
                  !%w[X O].include?(@board_markers[position.to_i])

    @board_markers.include?(position.to_i)
  end

  def winner?
    winner = false
    LINES.each do |line|
      if @board_markers[line[0]] == @board_markers[line[1]] &&
         @board_markers[line[0]] == @board_markers[line[2]]
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

player = players.next

play_game = 'y'
until play_game == 'n'
  board.reset

  until board.winner?
    board.display_board
    puts "Please choose a position (0-8) to place your #{player.marker} marker"
    position = gets.chomp.strip
    next unless board.valid_position?(position)

    # puts "You chose position #{position}"
    board.board_markers[position.to_i] = player.marker
    player = players.next unless board.winner?
  end

  board.display_board
  puts "#{player.name} (#{player.marker}) wins!"

  puts 'Play again? (y/n)'
  play_game = gets.chomp.strip
end
