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

    context '#win' do
      it 'puts result' do
        expect(@game).to receive(:puts).with(:@result)
        @game.send(:puts, :@result)
      end
      it 'should put the message WIN and call the method #answer' do
        expect(@game).to receive(:puts).with('You win! Do you want continue? Y/N')
        @game.send(:puts, 'You win! Do you want continue? Y/N')
        expect(@game).to receive(:answer)
        @game.send(:answer)
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
        @game.send(:answer)
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

    context '#answer' do
      it 'get the answer Y' do
        ans = 'Y'
        allow(ans).to receive(:gets).and_return('Y')
        allow(@game).to receive(:start)
        allow(@game).to receive(:attempt)
        expect($attempt_counter).to eq(1)
        expect(@game.hint_counter).to eq(0)
        @game.send(:answer)
        @game.start
        @game.attempt
      end
      it 'get the answer N' do
        ans = 'N'
        allow(@game).to receive(:save)
        allow(@game).to receive(:sleep).with(3)
        allow(@game).to receive(:exit)
        expect(@game).to receive(:puts).with('Bye!')
        @game.send(:puts, 'Bye!')
      end
      it 'put warning when answer not N/Y' do
        ans = 'any_other_input'
        expect(@game).to receive(:puts).with('Wrong input! Y or N?')
        #expect(@game).to receive(:answer).and_call_original
        @game.send(:puts, 'Wrong input! Y or N?')
      end
    end
  end
end
