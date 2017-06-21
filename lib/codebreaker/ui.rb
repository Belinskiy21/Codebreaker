
require 'pry'
module Codebreaker
  class UI
    include InfoSaver
    attr_accessor :game, :total_game, :total_loose, :total_win, :name, :datas

    def initialize
      @game = Game.new
      @total_loose = 0
      @total_win = 0
      @total_game = 1
      @name = ''
      @datas = []
    end

    def play
      @game.attempt_counter, @game.hint_counter, @game.result = 1, 0, ''
      @game.start
    end

    def menu
      puts 'I made a secret code with 4 numbers!
      You have 5 attempt to guess!' if @game.attempt_counter == 1
      puts "Try guess! Attempt N:#{ @game.attempt_counter }"
      puts "For hint type: 'hint'!" if @game.hint_counter == 0
      @game.attempt
      puts @game.hint_number if @game.cb_code == 'hint'
      ui_respond
    end

    def ui_respond
      @game.respond
      puts @game.result
      win if @game.result == '++++'
      loose if @game.attempt_counter > 5
      menu
    end

    def win
      @total_win += 1
      puts 'You win! Do you want continue? Y/N'
      answer
    end

    def loose
      @total_loose += 1
      puts 'You loose! Do you want continue? Y/N'
      answer
    end

    def answer
      player_say = gets.chomp
      if player_say == 'Y'
        @total_game += 1
        play
        menu
      elsif player_say == 'N'
        save
        puts 'Bye!'
        sleep 1
        exit
      else
        puts 'Wrong input! Y or N?'
        answer
      end
    end
  end
end
