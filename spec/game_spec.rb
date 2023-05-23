require './lib/game'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Game do
  subject(:game) { Game.new }

  describe '#input_position' do
    it 'gets input from player' do
      allow(game).to receive(:player_marker).and_return('X')
      allow(game).to receive(:puts)

      expect(game).to receive(:player_input).once

      game.input_position
    end
  end

  describe '#game_loop' do
    before do
      game.instance_variable_set(:@board, Board.new)

      allow(game).to receive(:next_player)
      allow(game).to receive(:display_board)

      allow(game.board).to receive(:valid_position?).and_return(true)
      allow(game).to receive(:input_position)

      allow(game).to receive(:player_marker)
    end

    context 'when there is a winner after player inputs position' do
      it 'sends update_marker to game.board once' do
        allow(game).to receive(:winner?).and_return(false, true)

        expect(game.board).to receive(:update_marker).once
        game.game_loop
      end
    end

    context 'when there is a winner after position is entered twice' do
      it 'sends update_marker to game.board twice' do
        allow(game).to receive(:winner?).and_return(false, false, true)

        expect(game.board).to receive(:update_marker).twice
        game.game_loop
      end
    end
  end

  describe '#show_win_screen' do
    let(:player) { double('player', name: 'Player 1') }

    context 'when there is a winner (not a tie)' do
      it 'displays the winner and asks the user if they want to play again' do
        game.instance_variable_set(:@board, Board.new)

        allow(game).to receive(:display_board)
        allow(game.board).to receive(:winner?).and_return(true)

        allow(game).to receive(:player).and_return(player)
        allow(game.player).to receive(:name)
        allow(game).to receive(:puts)
  
        allow(game).to receive(:player_input)
        
        expect(game).to receive(:player_marker)
        game.show_win_screen
      end
    end

    context 'when there is not a winner (a tie)' do
      it 'does not display the winner and asks the user if they want to play again' do
        game.instance_variable_set(:@board, Board.new)
        
        allow(game).to receive(:display_board)
        allow(game.board).to receive(:winner?).and_return(false)

        allow(game).to receive(:player).and_return(player)
        allow(game.player).to receive(:name)
        allow(game).to receive(:puts)
  
        allow(game).to receive(:player_input)
        
        expect(game).to_not receive(:player_marker)
        game.show_win_screen
      end
    end
  end

  describe '#play' do
    context 'when user enters "n"' do
      it 'sets up the game and runs the game loop then finishes loop' do
        allow(game).to receive(:reset_players)
        allow(game).to receive(:new_board)
        allow(game).to receive(:game_loop)
        allow(game).to receive(:show_win_screen).and_return('n')
  
        expect(game).to receive(:game_loop).once
  
        game.play
      end
    end

    context 'when user enters "y", then "n"' do
      it 'sets up the game and runs the game loop twice then finishes loop' do
        allow(game).to receive(:reset_players)
        allow(game).to receive(:new_board)
        allow(game).to receive(:game_loop)
        allow(game).to receive(:show_win_screen).and_return('y', 'n')
  
        expect(game).to receive(:game_loop).exactly(2).times
  
        game.play
      end
    end

  end
end
