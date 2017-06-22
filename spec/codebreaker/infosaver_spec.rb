require 'spec_helper'

module Codebreaker
  module InfoSaver
    RSpec.describe InfoSaver do
      before (:each) { @ui = UI.new }

      context '#user_name' do
        it 'should ask the name' do
          expect(@ui).to receive(:puts).with('What is your name?')
          allow(@ui.instance_variable_get(:@name)).to receive(:gets)
          .and_return(String)
          @ui.user_name
        end
      end

      context '#add_info' do
        it 'should write info to array' do
          @datas = []
          @ui.add_info
          expect(@ui).to receive(:user_name)
          expect(@ui.instance_variable_get(:@datas).size).to eq(4)
          @ui.user_name
        end
      end

      context '#save' do
        it 'should save information to file' do
          allow(@ui).to receive(:exist?).and_return(false)
          @ui.save
          expect(File.exist?('lib/codebreaker/game_info/game_info.txt'))
          .to eq(true)
          expect(@ui).to receive(:add_info)
          @ui.add_info
        end
      end
    end
  end
end
