# frozen_string_literal: true

require './lib/board'

RSpec.describe Board do
  subject(:board) { Board.new }

  describe '#reset' do
    it 'sets @markers to default value' do
      board.reset

      expect(board.markers).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
    end
  end

  describe '#valid_position?' do
    context 'when position is valid' do
      it 'returns true' do
        valid_position = '0'

        valid = board.valid_position?(valid_position)

        expect(valid).to eq(true)
      end
    end

    context 'when position is not a "number string"' do
      it 'returns false' do
        invalid_position = 'a'

        valid = board.valid_position?(invalid_position)

        expect(valid).to eq(false)
      end
    end

    context 'when position is outside the board position range' do
      it 'returns false' do
        invalid_position = '9'

        valid = board.valid_position?(invalid_position)

        expect(valid).to eq(false)
      end
    end

    context 'when position is taken by another marker' do
      it 'returns false' do
        board.markers = ['X', 1, 2, 3, 4, 5, 6, 7, 8]

        invalid_position = '0'

        valid = board.valid_position?(invalid_position)

        expect(valid).to eq(false)
      end
    end
  end

  describe '#winner?' do
    context 'when first row is 3 of the same marker' do
      it 'returns true' do
        board.markers = ['X', 'X', 'X', 3, 4, 5, 6, 7, 8]
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(true)
      end
    end

    context 'when second row is 3 of the same marker' do
      it 'returns true' do
        board.markers = [0, 1, 2, 'X', 'X', 'X', 6, 7, 8]
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(true)
      end
    end

    context 'when third row is 3 of the same marker' do
      it 'returns true' do
        board.markers = [0, 1, 2, 3, 4, 5, 'O', 'O', 'O']
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(true)
      end
    end

    context 'when first column is 3 of the same marker' do
      it 'returns true' do
        board.markers = ['X', 1, 2, 'X', 4, 5, 'X', 7, 8]
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(true)
      end
    end

    context 'when second column is 3 of the same marker' do
      it 'returns true' do
        board.markers = [0, 'O', 2, 3, 'O', 5, 6, 'O', 8]
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(true)
      end
    end

    context 'when third column is 3 of the same marker' do
      it 'returns true' do
        board.markers = [0, 1, 'X', 3, 4, 'X', 6, 7, 'X']
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(true)
      end
    end

    context 'when first diagonal is 3 of the same marker' do
      it 'returns true' do
        board.markers = ['O', 1, 2, 3, 'O', 5, 6, 7, 'O']
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(true)
      end
    end

    context 'when second diagonal is 3 of the same marker' do
      it 'returns true' do
        board.markers = [0, 1, 'X', 3, 'X', 5, 'X', 7, 8]
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(true)
      end
    end

    context 'when a row is different markers' do
      it 'returns false' do
        board.markers = ['X', 'X', 'O', 3, 4, 5, 6, 7, 8]
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(false)
      end
    end

    context 'when a column is different markers' do
      it 'returns false' do
        board.markers = [0, 'O', 2, 3, 'X', 5, 6, 'O', 8]
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(false)
      end
    end

    context 'when a diagonal is different markers' do
      it 'returns false' do
        board.markers = ['X', 1, 2, 3, 4, 5, 6, 7, 'O']
  
        is_winner = board.winner?
  
        expect(is_winner).to eq(false)
      end
    end

  end
end
