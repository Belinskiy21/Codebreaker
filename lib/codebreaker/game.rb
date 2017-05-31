module Codebreaker
  class Game
    def initialize
      @secret_code = ''
    end

    def start
      4.times { @secret_code << rand(1..6).to_s }
    end
  end
end
