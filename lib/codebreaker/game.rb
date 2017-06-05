module Codebreaker
  class Game
    attr_accessor :secret_code, :cb_code, :attempt_counter, :hint_counter, :result

    def initialize
      @secret_code = ''
      @cb_code = ''
      @attempt_counter = 1
      @hint_counter = 0
      @result = ''
    end

    def start
      4.times { @secret_code << rand(1..6).to_s }
      puts 'I made a secret code! You have 3 attempt to guess!'
    end

    def attempt
      puts "Try guess! Attempt N:#{@attempt_counter}"
      puts "For hint type: 'hint'!" unless @hint_counter == 1
      @cb_code = gets.chomp
      hint if @cb_code == 'hint'
      @attempt_counter += 1 unless @cb_code == 'hint'
    end

    def respond
      checker
      win if @result == '++++'
      loose if @attempt_counter > 3
      puts @result
      @result = ''
      attempt
      #respond
    end

    #private

    def win
      puts 'You win! Do you want continue? Y/N'
      answer
    end

    def loose
      puts 'You loose! Do you want continue? Y/N'
      answer
    end

    def hint
     hint_number = @secret_code.split('').sample
     puts hint_number
     @hint_counter += 1
    end

    def checker
      secret_code = @secret_code.split(''); cb_code = @cb_code.split('');
      4.times do |i|
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
      #answer = gets.chomp
      #if answer == 'Y'
       # @attempt_counter, @hint_counter = 1, 0
       # start
        #attempt
      #else
        #puts 'Bye!'
        #sleep 3
        #exit
      #end
    end
  end
end
