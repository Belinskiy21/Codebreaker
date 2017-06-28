
require 'yaml'

module Codebreaker
  module InfoSaver

    def user_name
      puts 'What is your name?'
      @name = gets.chomp
    end

    def add_info
      user_name
      @datas << "Player : #{@name}."
      @datas << "Games were played: #{@total_game}."
      @datas << "Win : #{@total_win}."
      @datas << "Loose : #{@total_loose}."
    end

    def save
      add_info
      File.open('lib/codebreaker/game_info/game_info.yml', 'a') {|f| f.write(@datas.to_yaml)}
      puts "#{@name}, your achivements were saved!"
    end
  end
end
