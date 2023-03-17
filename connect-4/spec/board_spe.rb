# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/prompt'
require_relative '../lib/interface'

describe Board do
  subject(:board) { Board.new(Prompt.new, 'Bill', 'Bob') }
  let(:interface) { Class.new { extend Interface } }

  describe '#revert_turn' do
    it "can revert turns between players" do
      board.revert_turn
      board.revert_turn
      expect(board.turn).to be true
    end
  end

  describe '#update_board' do
    context 'when the board is at a certain position, say empty' do
      it 'you can add a move' do
        initial_board = Array.new(7) { Array.new(6) }
        update_index = '3'
        board.update_at(update_index)

        expect(board.board[update_index.to_i][0]).to eq(interface.RED_CIRCLE)
      end
    end
  end
end