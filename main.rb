require_relative 'lib/codebreaker/game.rb'
require_relative 'lib/codebreaker/infosaver.rb'
require_relative 'lib/codebreaker/ui.rb'

module Codebreaker
  include InfoSaver
  include UI
  game = Game.new
  game.start
  game.menu
  game.attempt
end

