require_relative 'codebreaker/game.rb'

module Codebreaker
  game = Game.new
  game.start
  game.attempt
  game.respond
end
