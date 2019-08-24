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

end