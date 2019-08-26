require_relative 'mastermind_ai'

module Mastermind

    def self.check_guess(guess, solution) 
        bulls = 0
        cows = 0
        copy = solution.dup
        guess_copy = guess.dup

        guess_copy.each_with_index do |peg, index|
            if solution[index] == peg
                bulls += 1
                copy[index] = nil
                guess_copy[index] = nil
            end
        end

        copy.compact!
        guess_copy.compact!

        guess_copy.each do |peg|
            if copy.include?peg
                cows += 1
                copy.delete_at(copy.index(peg))
            end
        end

        return [bulls, cows]
    end

class Game
    NUM_TURNS = 12
    PEGS = ('A'..'F').to_a
    attr_reader :board

    def initialize
        @board = Array.new(4)
        @turns_remaining = 12
    end

    def randomize_board
        @board = @board.map {PEGS.sample}
    end

    def play
        mode = select_mode
        if mode == "1"
            play_codebreaker
        elsif mode == "2"
            play_codemaker
        end
    end

    def select_mode
        puts "Please select the mode you wish to play:\n 1 - to play as codebreaker\n 2 - to play as codemaker"
        mode = gets.chomp
        until mode.match(/^[1-2]$/) do
            puts "Invalid mode selected, try again:"
            mode = gets.chomp
        end
        mode
    end

    def play_codemaker
        secret = ""
        until(valid_guess?secret) do
            puts "Choose your secret:"
            secret = gets.chomp
        end
        @board = secret.split(//)

        turn = 1
        breaker = AI.new
        guess = breaker.first_guess
        until turn == 12 do
            puts "AI's guess #{turn} is: #{guess}"
            feedback = check_guess(guess.join)
            if feedback[0] == 4
                puts "The computer wins!"
                break
            else
                turn += 1
                guess = breaker.next_guess(guess, feedback)
            end
        end
    end
    

    def play_codebreaker
        randomize_board
        puts "Welcome to mastermind!"
        loop do
            guess = get_guess
            result = check_guess(guess)
            if result[0] == 4
                puts "You win!"
                break
            else
                puts "Guess #{guess} has #{result[0]} bulls and #{result[1]} cows"
                @turns_remaining -= 1
            end
            if @turns_remaining == 0
                puts "Out of turns, you lose!"
                puts "The secret was #{@board}"
                break
            end
        end
    end

    def check_guess(guess_string)
        Mastermind::check_guess(guess_string.split(//), board)
    end

    def get_guess
        print "#{@turns_remaining} turns left, input your guess:"
        guess = ""
        loop do
            guess = gets.chomp
            if valid_guess?(guess)
                break
            else
                puts "Invalid guess"
                print "Please input a valid guess:"
            end
        end
        return guess
    end

    def valid_guess?(guess)
        return guess.match(/^[A-F]{4}$/)
    end

end
end