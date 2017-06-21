require_relative 'lib/codebreaker/game.rb'
require_relative 'lib/codebreaker/infosaver.rb'
require_relative 'lib/codebreaker/ui.rb'

module Codebreaker
  ui = Codebreaker::UI.new
  ui.play
  ui.menu
end

