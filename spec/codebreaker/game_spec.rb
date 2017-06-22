require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    before (:each) { @game = Game.new }

    context '#start' do

      before do
        @game.generator
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
      it 'takes a string with cb code' do
        allow(@game.instance_variable_get(:@cb_code)).to receive(:gets).and_return(String)
        @game.attempt
      end
      it "call method #hint if put 'hint'" do
        @cb_code == 'hint'
        expect(@game).to receive(:hint)
        @game.hint
      end
      it 'make attempt counter increment' do
        @attempt_counter = 1
        @cb_code == '1234'
        expect{ @game.attempt }.to change{ @attempt_counter }.by(+1)
      end
    end

    context '#respond' do
      it 'clear result' do
        expect(@game.instance_variable_get(:@result)).to eq('')
      it 'check result with method #checker' do
        expect(@game).to receive(:checker).and_return(:@result)
        @game.send(:checker)
      end
    end

    context '#hint' do
      before do
        @game.instance_variable_set(:@secret_code, '1234')
        @game.hint
      end
      it 'should take random sample from secret code' do
        expect(@game.instance_variable_get(:@secret_code)).to include(@game.hint_number)
      end
      it 'should change hint counter by 1' do
        @hint_counter = 0
        @game.hint
        expect{ @game.hint }.to change{ @game.hint_counter }.by(+1)
      end
    end

    context '#checker' do
      before do
        @game.instance_variable_set(:@secret_code, '3211')
        @game.instance_variable_set(:@cb_code, '3222')
        @game.send(:checker)
      end
      it 'should return result after comparing secret code with cb code' do
        expect(@game.result).to eq('++')
      end
    end
  end
end
