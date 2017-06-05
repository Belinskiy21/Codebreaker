require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    before (:each) { @game = Game.new }

    context '#start' do

      before do
        @game.start
      end
      it 'saves secret code' do
        expect(@game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it 'saves 4 numbers secret code' do
        expect(@game.instance_variable_get(:@secret_code).size).to eq(4)
      end
      it 'saves secret code with numbers from 1 to 6' do
        expect(@game.instance_variable_get(:@secret_code)).to match(/^[1-6]{4}$/)
      end
    end

    context '#attempt' do

      before do
        @game.attempt
      end
      it 'puts cb code' do
        allow(@game.instance_variable_get(:@cb_code)).to receive(:gets).and_return(String)
        @game.attempt
      end
      it "call method #hint if put 'hint'" do
        allow(@cb_code == 'hint')
        expect(@game).to receive(:hint)
        @game.hint
      end
      it 'make attempt counter increment' do
        allow( @attempt_counter = 1)
        allow(@cb_code == '1234')
        expect{ @game.attempt }.to change{ @game.attempt_counter }.by(+1)
      end
    end

    context '#respond' do
      before do
        @game.respond
      end
      it 'check result with method #checker' do
        expect(@game).to receive(:checker).and_return(:@result)
        @game.checker
      end
      it 'call method #win when result is ++++' do
        allow(@result == '++++')
        expect(@game).to receive(:win)
        @game.win
      end
      it 'call method #loose when attempt counter > 3' do
        allow(@attempt_counter == 4)
        expect(@game).to receive(:loose)
        @game.loose
      end
      it 'puts result' do
        expect(@game).to receive(:puts).with(:@result)
        @game.send(:puts, :@result)
      end
      it 'make result empty string' do
        expect(@game.instance_variable_get(:@result)).to eq('')
      end
      it 'call method #attempt' do
        expect(@game).to receive(:attempt)
        @game.attempt
      end
    end

    context '#win' do
      before do
        @game.win
      end
      it 'should put the message WIN and call the method #answer' do
        expect(@game).to receive(:puts).with('You win! Do you want continue? Y/N')
        @game.send(:puts, 'You win! Do you want continue? Y/N')
        expect(@game).to receive(:answer)
        @game.answer
      end
    end

    context '#loose' do
      before do
        @game.loose
      end
      it 'should put the message LOOSE and call the method #answer' do
        expect(@game).to receive(:puts).with('You loose! Do you want continue? Y/N')
        @game.send(:puts, 'You loose! Do you want continue? Y/N')
        expect(@game).to receive(:answer)
        @game.answer
      end
    end
  end
end
