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
      it 'puts cb code' do
        allow(@game.instance_variable_get(:@cb_code)).to receive(:gets).and_return(String)
        @game.attempt
      end
      it 'raise error if cb code size not 4' do
        @game.instance_variable_set(:@cb_code, '12')
        @game.attempt
        expect{ @cb_code .gets }.to raise_error(Exception)
      end

      it "call method #hint if put 'hint'" do
        @cb_code == 'hint'
        expect(@game).to receive(:hint)
        @game.send(:hint)
      end
      it 'make attempt counter increment' do
        $attempt_counter = 1
        @cb_code == '1234'
        expect{ @game.attempt }.to change{ $attempt_counter }.by(+1)
      end
    end

    context '#respond' do
      it 'check result with method #checker' do
        expect(@game).to receive(:checker).and_return(:@result)
        @game.send(:checker)
      end
      it 'call method #win when result is ++++' do
        @result == '++++'
        expect(@game).to receive(:win)
        @game.send(:win)
      end
      it 'call method #loose when attempt counter > 3' do
        $attempt_counter == 4
        expect(@game).to receive(:loose)
        @game.send(:loose)
      end
      it 'puts result' do
        expect(@game).to receive(:puts).with(:@result)
        @game.send(:puts, :@result)
      end
      it 'make result empty string' do
        expect(@game.instance_variable_get(:@result)).to eq('')
      end
    end

    context '#hint' do
      before do
        @game.instance_variable_set(:@secret_code, '1234')
        @game.send(:hint)
      end
      it 'should take random sample from secret code' do
        expect(@game.instance_variable_get(:@secret_code)).to include(@game.hint_number)
      end
      it 'should change hint counter by 1' do
        @hint_counter = 0
        @game.send(:hint)
        expect{ @game.send(:hint) }.to change{ @game.hint_counter }.by(+1)
      end
    end

    context '#checker' do
      before do
        @game.instance_variable_set(:@secret_code, '1234')
        @game.instance_variable_set(:@cb_code, '1222')
        @game.send(:checker)
      end
      it 'should return result after comparing secret code with cb code' do
        expect(@game.result).to eq('++')
      end
    end
  end
end
