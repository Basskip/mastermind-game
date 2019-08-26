require_relative 'mastermind'

class AI
    def initialize
        @set_s = ('A'..'F').to_a.repeated_permutation(4).to_a
        @guesses = ('A'..'F').to_a.repeated_permutation(4).to_a

        puts @set_s.size
    end

    def next_guess(prev_guess, feedback)

        @set_s.select! { |combo| Mastermind.check_guess(prev_guess, combo) == feedback }

        @guesses.delete(prev_guess)

        guesses_hash = @guesses.map do |guess|
            [guess, score(guess,@set_s)]
        end.to_h

        best_guesses = guesses_hash.select { |k, v| v == guesses_hash.values.min }
        best_guesses = best_guesses.keys
        s_guesses = best_guesses & @set_s

        if s_guesses.size > 0
            best_guess = s_guesses.sort.first
        else
            best_guess = best_guesses.sort.first
        end
        return best_guess
    end
    
    def score(guess, candidates)
        feedbacks = candidates.map {|c| Mastermind.check_guess(guess,c)}
        feed_counts = Hash.new(0)
        feedbacks.each {|feedback| feed_counts[feedback] += 1}
        return feed_counts.values.max
    end
end