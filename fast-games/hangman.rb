module Hangman
  def Hangman.start
    secret_word = File.readlines("secret_words.txt").sample
    right_letters = secret_word.chomp.split('').map { |letter| '_' }
    attempts = self.set_difficulty_attempts(secret_word.length)
    bet_letters = []

    puts('********************')
    puts('****HANGMAN GAME****')
    puts("******************** \n\n")

    while attempts > 0
      puts("-------------------------- \n\n")
      puts("You have #{attempts} attempt(s) remaining. \n\n")
      puts("BETS: #{bet_letters.join(", ")}")
      puts("WORD: #{right_letters.join(' ')} \n\n")

      print('Digit a new letter:')
      new_bet_letter = gets().chomp().upcase

      if self.right_bet(new_bet_letter, bet_letters)
        if !secret_word.include?(new_bet_letter)
          attempts -= 1
        end

        bet_letters << new_bet_letter
        bet_letters.sort

        right_letters =
          set_right_letters(secret_word, new_bet_letter, right_letters)
      else
        if bet_letters.include?(new_bet_letter)
          puts("Letter '#{new_bet_letter}' was been informed before. Try another one.")
        else
          puts('Wrong value informed. Put only one LETTER.')
        end
      end

      if !right_letters.include? '_'
        puts "Congratulations! You right the secret word: '#{secret_word}'"
        break
      elsif attempts == 0
        puts "You Lose! The secrect word was #{secret_word}"
      end
    end
  end

  def Hangman.set_difficulty_attempts(word_length)
    attempts = nil

    while attempts == nil
      puts('Inform the difficulty level')
      puts("1- Easy \n2- Medium \n3- Hard")
      print('Put the difficulty: ')
      level = gets().to_i

      puts(level.to_i)
      if level == 1
        attempts = (2.5 * word_length).round
      elsif level == 2
        attempts = (2.0 * word_length).round
      elsif level == 3
        attempts = (1.5 * word_length).round
      else
        puts("Not valid level. Insert between 1 and 3 \n\n")
      end
    end

    return attempts
  end

  def Hangman.right_bet(new_bet, bet_list)
    return(
      new_bet.length == 1 &&
      !bet_list.include?(new_bet)
    )
  end

  def Hangman.set_right_letters(secret_word, new_bet_letter, right_letters)
    secret_word.split('').each_with_index do |word, index|
      secret_letter = secret_word[index].upcase
      if new_bet_letter == secret_letter
        right_letters[index] = secret_letter
      end
    end

    return right_letters
  end
end
