require './lib/game'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Game do
  let(:board) { double('board') }
  subject(:game) { Game.new }

  describe '#input_position' do
    # Only calls puts. No test needed
  end

  describe '#game_loop' do
    # 1. Command Method -> Test the change in the observable state
    # 3. Method with Outgoing Command -> Test that a message is sent
    # 4. Looping Script Method -> Test the behavior of the method

    context 'when game_over? is false once' do
      before do
        game.reset_players
        game.instance_variable_set(:@board, board)

        allow(game).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:display_board)
        allow(game).to receive(:input_position)
      end

      it 'calls board.update_marker once' do
        expect(board).to receive(:update_marker).once
        game.game_loop
      end
    end

    context 'when game_over? is false twice' do
      before do
        game.reset_players
        game.instance_variable_set(:@board, board)

        allow(game).to receive(:game_over?).and_return(false, false, true)
        allow(game).to receive(:display_board)
        allow(game).to receive(:input_position)
      end

      it 'calls board.update_marker twice' do
        expect(board).to receive(:update_marker).twice
        game.game_loop
      end
    end

    context 'when game_over? is false five times' do
      before do
        game.reset_players
        game.instance_variable_set(:@board, board)

        allow(game).to receive(:game_over?)
          .and_return(false, false, false, false, false, true)
        allow(game).to receive(:display_board)
        allow(game).to receive(:input_position)
      end

      it 'calls board.update_marker 5 times' do
        expect(board).to receive(:update_marker).exactly(5).times
        game.game_loop
      end
    end
  end

  describe '#show_win_screen' do
    let(:player) { double('player', name: 'Player 1') }

    context 'when there is a winner (not a tie)' do
      it 'displays the winner and asks the user if they want to play again' do
        game.instance_variable_set(:@board, board)

        allow(game).to receive(:display_board)
        allow(board).to receive(:winner?).and_return(true)

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
        game.instance_variable_set(:@board, board)

        allow(game).to receive(:display_board)
        allow(board).to receive(:winner?).and_return(false)

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

  describe '#next_player' do
  end

  describe '#display_board' do
  end
end
