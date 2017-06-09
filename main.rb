require_relative 'lib/codebreaker/game.rb'
require_relative 'lib/codebreaker/infosaver.rb'

module Codebreaker
  include InfoSaver
  game = Game.new
  game.start
  while $attempt_counter < 6 do
    game.attempt
    game.respond
  end
end

