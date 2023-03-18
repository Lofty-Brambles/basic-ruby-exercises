# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/prompt'
require_relative '../lib/interface'

describe Board do
  subject(:board) { Board.new(Prompt.new, 'Bill', 'Bob') }

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
        update_at = '3'
        update_index = update_at.to_i - 1
        board.update_board(update_at)

        expect(board.board[update_index][0]).to eq(Interface::RED_CIRCLE)
      end
    end
  end

  describe '#declare_winner' do
    context 'when result is a draw or over' do
      it 'calls show_results once' do
        board.results = { status: 'draw' }
        allow(board).to receive(:show_results).and_return(nil)
        expect(board).to receive(:show_results).once
        board.declare_winner
      end
    end
  end
end