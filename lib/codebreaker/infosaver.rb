require_relative 'game.rb'
module Codebreaker
  module InfoSaver
     attr_accessor :name, :lists

    def initialize
      @name = ''
    end

    def user_name
      puts 'What is your name?'
      @name = gets.chomp
    end

    def add_info
      user_name
      @datas = []
      @datas << "Player : #{@name}."
      @datas << "Win : #{$total_wins}."
      @datas << "Loose : #{$total_loose}."
    end

    def save
      add_info
      serialized_datas = Marshal.dump(@datas)
      File.open('lib/codebreaker/game_info/game_info.txt', 'a') {|f| f.write(serialized_datas)}
      puts "#{@name}, your achivements were saved!"
    end
  end
end
