require './lib/game'

require 'pry-byebug'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Game do
  let(:board) { double('board') }
  subject(:game) { Game.new }

  describe '#input_position' do
    # 3. Method with Outgoing Command -> Test that a message is sent
    # 4. Looping Script Method -> Test the behavior of the method
    # 2. Query Method -> Test the return value

    context 'when player inputs a valid position the first time' do
      before do
        game.instance_variable_set(:@board, board)

        allow(board).to receive(:valid_position?).and_return(false, true)
        allow(game).to receive(:player_marker)
        allow(game).to receive(:puts)
        allow(game).to receive(:player_input).once
      end

      it 'sends valid_position message to board twice (initial check and after player inputs once)' do
        expect(board).to receive(:valid_position?).twice
        game.input_position
      end
    end

    context 'when board.valid_position? is false once' do
      before do
        game.instance_variable_set(:@board, board)

        allow(board).to receive(:valid_position?).and_return(false, true)
        allow(game).to receive(:player_marker)
        allow(game).to receive(:puts)
      end

      it 'calls player_input once' do
        expect(game).to receive(:player_input).once
        game.input_position
      end
    end

    context 'when board.valid_position? is false twice' do
      before do
        game.instance_variable_set(:@board, board)

        allow(board).to receive(:valid_position?).and_return(false, false, true)
        allow(game).to receive(:player_marker)
        allow(game).to receive(:puts)
      end

      it 'calls player_input twice' do
        expect(game).to receive(:player_input).twice
        game.input_position
      end
    end

    context 'when board.valid_position? is false once' do
      before do
        game.instance_variable_set(:@board, board)

        allow(board).to receive(:valid_position?).and_return(false, true)
        allow(game).to receive(:player_marker)
        allow(game).to receive(:puts)
        allow(game).to receive(:player_input).and_return('7')
      end

      it 'returns the position entered by the player' do
        position = game.input_position
        expect(position).to eq('7')
      end
    end
  end

  describe '#game_loop' do
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
    # Only contains puts statements -> no test necessary
  end

  describe '#play' do
    # 4. Looping Script Method -> Test the behavior of the method

    context 'when user enters "y" once' do
      before do
        allow(game).to receive(:set_up)
        allow(game).to receive(:game_loop)
        allow(game).to receive(:show_win_screen)
        allow(game).to receive(:prompt_to_play_again).and_return('y', 'n')
      end

      it 'completes loop twice and prompts to play again twice' do
        expect(game).to receive(:prompt_to_play_again).twice
        game.play
      end
    end

    context 'when user enters "y" twice' do
      before do
        allow(game).to receive(:set_up)
        allow(game).to receive(:game_loop)
        allow(game).to receive(:show_win_screen)
        allow(game).to receive(:prompt_to_play_again).and_return('y', 'y', 'n')
      end

      it 'completes loop three times and prompts to play again three times' do
        expect(game).to receive(:prompt_to_play_again).exactly(3).times
        game.play
      end
    end
  end

  describe '#next_player' do
    # 1. Command Method -> Test the change in the observable state

    context 'when player is nil' do
      before do
        game.reset_players
      end

      it 'sets player to "Player 1"' do
        game.next_player

        player = game.player

        expect(player.name).to eq('Player 1')
      end
    end

    context 'when player is "Player 1"' do
      before do
        game.reset_players
        game.next_player
      end

      it 'sets player to "Player 2"' do
        expect { game.next_player }.to change { game.player.name }
          .from('Player 1').to('Player 2')
      end
    end

    context 'when player is "Player 2"' do
      before do
        game.reset_players
        game.next_player
        game.next_player
      end

      it 'sets player to "Player 1"' do
        expect { game.next_player }.to change { game.player.name }
        .from('Player 2').to('Player 1')
      end
    end
  end

  describe '#display_board' do
    # Method with Outgoing Command - test that the message gets sent
    before do
      game.instance_variable_set(:@board, board)
    end

    it 'sends display_board message to board' do
      expect(board).to receive(:display_board)
      game.display_board
    end
  end

  describe '#player_marker' do
    # Query method - test the return value
    
    context 'when current player is "Player 1"' do
      before do
        game.reset_players
        game.next_player
      end

      it 'returns the current player marker symbol' do
        marker = game.player_marker
        expect(marker).to eq('X')
      end
    end

    context 'when current player is "Player 2"' do
      before do
        game.reset_players
        game.next_player
        game.next_player
      end

      it 'returns the current player marker symbol' do
        marker = game.player_marker
        expect(marker).to eq('O')
      end
    end
  end
end
