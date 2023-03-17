# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#play_loop' do
    subject(:game) { described_class.new }

    context 'when user just wants to play once' do
      it 'loops only once' do
        allow(game).to receive(:play_game).and_return(nil)
        allow(game).to receive(:play_again?).and_return(false)
        expect(game).to receive(:play_game).once
        game.play_loop
      end
    end

    context 'when user wants to play multiple times' do
      it 'loops multiple times' do
        allow(game).to receive(:play_game).and_return(nil)
        allow(game).to receive(:play_again?).and_return(true, true, false)
        expect(game).to receive(:play_game).thrice
        game.play_loop
      end
    end
  end
end