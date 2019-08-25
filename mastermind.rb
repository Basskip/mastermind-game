class Mastermind
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

    def guess(guess)
        bulls = 0
        cows = 0
        copy = @board.dup

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

        return "Bulls: #{bulls} Cows: #{cows}"
    end

end