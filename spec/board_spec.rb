# frozen_string_literal: true

require './lib/board'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#update_marker' do
    # 1. Command Method -> Test the change in the observable state

    it 'updates the markers array' do
      position = 0
      marker = 'X'
      
      board.update_marker(position, marker)

      expect(board.markers[0]).to eq('X')
    end
  end

  describe '#valid_position?' do
    # 2. Query Method -> Test the return value
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
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['X', 1, 2, 3, 4, 5, 6, 7, 8] }

      it 'returns false' do
        invalid_position = '0'

        valid = board.valid_position?(invalid_position)

        expect(valid).to eq(false)
      end
    end
  end

  describe '#winner?' do
    # 2. Query Method -> Test the return value
    context 'when first row is 3 of the same marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['X', 'X', 'X', 3, 4, 5, 6, 7, 8] }

      it 'returns true' do
        is_winner = board.winner?

        expect(is_winner).to eq(true)
      end
    end

    context 'when second row is 3 of the same marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { [0, 1, 2, 'X', 'X', 'X', 6, 7, 8] }

      it 'returns true' do
        is_winner = board.winner?

        expect(is_winner).to eq(true)
      end
    end

    context 'when third row is 3 of the same marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { [0, 1, 2, 3, 4, 5, 'O', 'O', 'O'] }

      it 'returns true' do
        is_winner = board.winner?

        expect(is_winner).to eq(true)
      end
    end

    context 'when first column is 3 of the same marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['X', 1, 2, 'X', 4, 5, 'X', 7, 8] }

      it 'returns true' do
        is_winner = board.winner?

        expect(is_winner).to eq(true)
      end
    end

    context 'when second column is 3 of the same marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { [0, 'O', 2, 3, 'O', 5, 6, 'O', 8] }

      it 'returns true' do
        is_winner = board.winner?

        expect(is_winner).to eq(true)
      end
    end

    context 'when third column is 3 of the same marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { [0, 1, 'X', 3, 4, 'X', 6, 7, 'X'] }

      it 'returns true' do
        is_winner = board.winner?

        expect(is_winner).to eq(true)
      end
    end

    context 'when first diagonal is 3 of the same marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['O', 1, 2, 3, 'O', 5, 6, 7, 'O'] }

      it 'returns true' do
        is_winner = board.winner?

        expect(is_winner).to eq(true)
      end
    end

    context 'when second diagonal is 3 of the same marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { [0, 1, 'X', 3, 'X', 5, 'X', 7, 8] }

      it 'returns true' do
        is_winner = board.winner?

        expect(is_winner).to eq(true)
      end
    end

    context 'when a row is different markers' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['X', 'X', 'O', 3, 4, 5, 6, 7, 8] }

      it 'returns false' do
        is_winner = board.winner?

        expect(is_winner).to eq(false)
      end
    end

    context 'when a column is different markers' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { [0, 'O', 2, 3, 'X', 5, 6, 'O', 8] }

      it 'returns false' do
        is_winner = board.winner?

        expect(is_winner).to eq(false)
      end
    end

    context 'when a diagonal is different markers' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['X', 1, 2, 3, 4, 5, 6, 7, 'O'] }

      it 'returns false' do
        is_winner = board.winner?

        expect(is_winner).to eq(false)
      end
    end
  end

  describe '#full?' do
    # 2. Query Method -> Test the return value

    context 'when the board is filled with markers' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['X', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 'O'] }

      it 'returns true' do
        expect(board).to be_full
      end
    end

    context 'when the board is not filled with markers' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['X', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 8] }

      it 'returns false' do
        expect(board).not_to be_full
      end
    end
  end
end
