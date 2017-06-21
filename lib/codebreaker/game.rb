require 'pry'
module Codebreaker
  class Game
    attr_accessor :secret_code, :cb_code, :hint_counter,
     :result, :hint_number, :attempt_counter

    def initialize
      @secret_code = ''
      @cb_code = ''
      @hint_counter = 0
      @result = ''
      @attempt_counter = 1
    end

    def start
      @secret_code = generator
    end

    def generator
      4.times.map { rand(1..6) }.join
    end

    def attempt
      @cb_code = gets.chomp
      hint if @cb_code == 'hint'
      @attempt_counter += 1 unless @cb_code == 'hint'
    end

    def respond
      @result.clear
      checker(@secret_code.split(''), @cb_code.split(''))
    end

    def hint
     @hint_counter += 1
     @hint_number = @secret_code[rand(0..3)] if @hint_counter < 2
    end

    private

    def checker(secret_code, cb_code)
      exclude_match = cb_code.zip(secret_code)
      .select { |guess, secret| guess != secret}.transpose
      @result = '+' * (4 - exclude_match[0].size)
      include_matches(exclude_match[0], exclude_match[1])
    end

    def include_matches(secret_code, cb_code)
      secret_code.each do |val|
        next if !cb_code.include?(val)
        cb_code.delete_at(cb_code.index(val))
        @result += '-'
      end
    end
  end
end
