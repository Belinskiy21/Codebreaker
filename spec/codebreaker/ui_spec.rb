require 'spec_helper'

module Codebreaker
  RSpec.describe UI do
    let(:game) { Game.new }
    let (:ui) { UI.new }

     before :each do
      ui.play
    end

    context '#play' do
      it 'start the game with method start' do
        expect(ui).to receive(game.start)
      end

    end
    context '#menu' do
      it 'puts messages for user' do
        game.attempt_counter != 1
        game.hint_counter != 0
        expect(ui).not_to receive(:puts).with('I made a secret code with 4 numbers! You have 5 attempt to guess!')
        expect(ui).to receive(:puts).with("Try guess! Attempt N:#{game.attempt_counter}")
        expect(ui).not_to receive(:puts).with("For hint type: 'hint'!")
      end
    end

      context '#ui_respond' do
        it 'puts result' do
          expect(ui).to receive(:puts).with(game.result)
          ui.send(:puts, game.result)
        end
        it 'call method #win when result is ++++' do
          game.result == '++++'
          expect(ui).to receive(:win)
          ui.win
        end
        it 'call method #loose when attempt counter > 5' do
          game.attempt_counter == 6
          expect(ui).to receive(:loose)
          ui.loose
        end
      end

    context '#win' do
      it 'should put the message WIN and call the method #answer' do
        expect(ui).to receive(:puts).with('You win! Do you want continue? Y/N')
        ui.send(:puts, 'You win! Do you want continue? Y/N')
        expect(ui).to receive(:answer)
        ui.answer
      end
    end

    context '#loose' do
      it 'should put the message LOOSE and call the method #answer' do
        expect(ui).to receive(:puts).with('You loose! Do you want continue? Y/N')
        ui.send(:puts, 'You loose! Do you want continue? Y/N')
        expect(ui).to receive(:answer)
        ui.answer
      end
    end

    context '#answer' do
      it 'get the answer Y' do
        player_say = 'Y'
        allow(player_say).to receive(:gets).and_return('Y')
        expect(ui.answer).to change{ @total_game }.by(+1)
        allow(ui).to receive(:play)
        allow(ui).to receive(:menu)
        ui.answer
        ui.play
        ui.menu
      end
      it 'get the answer N' do
        player_say = 'N'
        allow(ui).to receive(:save)
        allow(ui).to receive(:sleep).with(1)
        allow(ui).to receive(:exit)
        expect(ui).to receive(:puts).with('Bye!')
        ui.send(:puts, 'Bye!')
      end
      it 'put warning when answer not N/Y' do
        player_say = 'any_other_input'
        expect(ui).to receive(:puts).with('Wrong input! Y or N?')
        ui.send(:puts, 'Wrong input! Y or N?')
      end
    end
  end
end
