require_relative 'infosaver.rb'
module Codebreaker
  class Game
    include InfoSaver
    include UI
    attr_accessor :secret_code, :cb_code, :attempt_counter, :hint_counter, :result, :hint_number, :total_loose, :total_win, :name, :datas

    def initialize
      @secret_code = ''
      @cb_code = ''
      @total_loose = 0
      @total_win = 0
      $attempt_counter = 1
      @hint_counter = 0
      @result = ''
      @name = ''
      @datas = []
    end

    def start
      @secret_code = 4.times.map { rand(1..6) }.join
    end

    def attempt
      @cb_code = gets.chomp
      hint if @cb_code == 'hint'
      $attempt_counter += 1 unless @cb_code == 'hint'
      respond
    end

    def respond
      puts checker
      win if @result == '++++'
      loose if $attempt_counter > 5
      @result = ''
      menu
      attempt
    end

    private

    def hint
     @hint_counter += 1
     if @hint_counter < 2
      puts @hint_number = @secret_code.split('').sample
     else
      puts 'You have no hints no more!'
     end
    end

    def checker
      secret_code = @secret_code.split(''); cb_code = @cb_code.split('');
      secret_code.length.times do |i|
        if secret_code[i] == cb_code[i]
          @result += '+'
          secret_code[i], cb_code[i] = nil, nil
        end
      end
      secret_code.compact!; cb_code.compact!;
      cb_code.each { |el| @result += '-' if secret_code.include?(el) }
      @result
    end
  end
end
