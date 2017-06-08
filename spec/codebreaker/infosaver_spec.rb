require 'spec_helper'

module Codebreaker
  module InfoSaver
    RSpec.describe InfoSaver do
      before (:each) { @game = Game.new }

      context '#user_name' do
        it 'should ask the name' do
          expect(@game).to receive(:puts).with('What is your name?')
          allow(@game.instance_variable_get(:@name)).to receive(:gets).and_return(String)
          @game.user_name
        end
      end

      context '#add_info' do
        it 'should write info to array' do
          @datas = []
          @game.add_info
          expect(@game).to receive(:user_name)
          expect(@game.instance_variable_get(:@datas).size).to eq(3)
          @game.user_name
        end
      end

      context '#save' do
        it 'should save information to file' do
          allow(@game).to receive(:exists?).and_return(false)
          @game.save
          expect(File.exists?('lib/codebreaker/game_info/game_info.txt')).to eq(true)
          expect(@game).to receive(:add_info)
          @game.add_info

        end
      end
    end
  end
end
