require_relative 'guess'
require_relative 'hangman'

puts('*****************')
puts('****HUB GAMES****')
puts("***************** \n\n")

puts('Which game do you want to play?')
puts("1- Guess \n2- Hangman \n\n")

print('Put the game number:')
game_choice = gets().to_i
puts(game_choice.class)
puts("------------------------------ \n\n")

if game_choice == 1
  Guess.start()
elsif game_choice == 2
  Hangman.start()
else
  print('Invalid value. Put one in the list')
end

