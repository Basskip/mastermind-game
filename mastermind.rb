module Mastermind

    def Mastermind.check_guess(guess, solution) 
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
        bulls = 0
        cows = 0
        copy = @board.dup
        guess = guess_string.split(//)

        guess.each_with_index do |peg, index|
            if @board[index] == peg
                bulls += 1
                copy[index] = nil
                guess[index] = nil
            end
        end

        copy.compact!
        guess.compact!

        guess.each do |peg|
            if copy.include?peg
                cows += 1
                copy.delete_at(copy.index(peg))
            end
        end

        return [bulls, cows]
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