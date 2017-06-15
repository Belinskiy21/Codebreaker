module Codebreaker
  module UI

    def menu
      puts 'I made a secret code with 4 numbers! You have 5 attempt to guess!' if $attempt_counter == 1
      puts "Try guess! Attempt N:#{$attempt_counter}"
      puts "For hint type: 'hint'!" if @hint_counter ==0
    end

    def win
      puts @result
      @total_win += 1
      puts 'You win! Do you want continue? Y/N'
      answer
    end

    def loose
      puts @result
      @total_loose += 1
      puts 'You loose! Do you want continue? Y/N'
      answer
    end

    def answer
      player_say = gets.chomp
      if player_say == 'Y'
        $attempt_counter, @hint_counter, @result = 1, 0, ''
        start
        menu
        attempt
        respond
      elsif player_say == 'N'
        save
        puts 'Bye!'
        sleep 3
        exit
      else
        puts 'Wrong input! Y or N?'
        answer
      end
    end
  end
end
