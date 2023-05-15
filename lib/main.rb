require './lib/tic_tac_toe'

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

    board.markers[position.to_i] = player.marker
    player = players.next unless board.winner?
  end

  board.display_board
  puts "\n#{player.name} (#{player.marker}) wins!"

  puts "\nPlay again? (y/n)"
  play_game = gets.chomp.strip
end
