#require_relative 'infosaver.rb'
module Codebreaker
  class Game
    #include InfoSaver
    attr_accessor :secret_code, :cb_code, :at, :total_loose, :total_win, :hint_counter, :result, :hint_number

    def initialize
      @secret_code = ''
      @cb_code = ''
      $attempt_counter = 1
      $total_loose = 0
      $total_win = 0
      @hint_counter = 0
      @result = ''
    end

    def start
      4.times { @secret_code << rand(1..6).to_s }
      puts 'I made a secret code! You have 5 attempt to guess!'
    end

    def attempt
      puts "Try guess! Attempt N:#{$attempt_counter}"
      puts "For hint type: 'hint'!" unless @hint_counter == 1
      begin
        @cb_code = gets.chomp
        raise 'Wrang number of code elements! Should be 4!' if @cb_code.size != 4
      rescue Exception => e
        puts e.message
        @cb_code = gets.chomp
      end
      hint if @cb_code == 'hint'
      $attempt_counter += 1 unless @cb_code == 'hint'
    end

    def respond
      checker
      win if @result == '++++'
      loose if $attempt_counter > 5
      puts @result
      @result = ''
    end

    private

    def win
      puts @result
      $total_win += 1
      puts 'You win! Do you want continue? Y/N'
      answer
    end

    def loose
      puts @result
      puts 'You loose! Do you want continue? Y/N'
      $total_loose +=1
      answer
    end

    def hint
     puts @hint_number = @secret_code.split('').sample
     @hint_counter += 1
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

    def answer
        ans = gets.chomp
      if ans == 'Y'
        $attempt_counter, @hint_counter = 1, 0
       start
       attempt
      elsif ans == 'N'
        save
        puts 'Bye!'
        sleep 3
        exit
      else
        puts ('Wrong input! Y or N?')
        #answer
      end
    end
  end
end
