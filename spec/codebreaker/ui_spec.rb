require 'spec_helper'

module Codebreaker
  RSpec.describe UI do
    before (:each) { @game = Game.new }

    context '#menu' do
      it 'puts messages for user' do
        $attempt_counter != 1
        @hint_counter != 0
        expect(@game).not_to receive(:puts).with('I made a secret code with 4 numbers! You have 5 attempt to guess!')
        expect(@game).to receive(:puts).with("Try guess! Attempt N:#{$attempt_counter}")
        expect(@game).not_to receive(:puts).with("For hint type: 'hint'!")
      end
    end

    context '#win' do
      it 'puts result' do
        expect(@game).to receive(:puts).with(:@result)
        @game.send(:puts, :@result)
      end
      it 'should put the message WIN and call the method #answer' do
        expect(@game).to receive(:puts).with('You win! Do you want continue? Y/N')
        @game.send(:puts, 'You win! Do you want continue? Y/N')
        expect(@game).to receive(:answer)
        @game.answer
      end
    end

    context '#loose' do
      it 'puts result' do
        expect(@game).to receive(:puts).with(:@result)
        @game.send(:puts, :@result)
      end
      it 'should put the message LOOSE and call the method #answer' do
        expect(@game).to receive(:puts).with('You loose! Do you want continue? Y/N')
        @game.send(:puts, 'You loose! Do you want continue? Y/N')
        expect(@game).to receive(:answer)
        @game.answer
      end
    end

    context '#answer' do
      it 'get the answer Y' do
        player_say = 'Y'
        allow(player_say).to receive(:gets).and_return('Y')
        allow(@game).to receive(:start)
        allow(@game).to receive(:attempt)
        expect($attempt_counter).to eq(1)
        expect(@game.hint_counter).to eq(0)
        expect(@game.result).to eq('')
        @game.answer
        @game.start
        @game.attempt
      end
      it 'get the answer N' do
        player_say = 'N'
        allow(@game).to receive(:save)
        allow(@game).to receive(:sleep).with(3)
        allow(@game).to receive(:exit)
        expect(@game).to receive(:puts).with('Bye!')
        @game.send(:puts, 'Bye!')
      end
      it 'put warning when answer not N/Y' do
        player_answer = 'any_other_input'
        expect(@game).to receive(:puts).with('Wrong input! Y or N?')
        @game.send(:puts, 'Wrong input! Y or N?')
      end
    end

  end
end
