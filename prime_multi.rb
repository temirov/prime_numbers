require 'prime'

class PrimeMulti
  class << self
    def list_non_optimized total, candidate: 2
      raise ArgumentError unless total.is_a? Integer
      primes = []
      possible_prime = candidate
      while primes.count < total
        j = candidate
        while j <= possible_prime
          break if (possible_prime % j).zero?
          j += 1
        end
        primes << possible_prime if j == possible_prime
        possible_prime += 1
      end
      primes
    end
    def list total, start_from: 2, method: :optimized
      case method
      when :optimized
        list_optimized total, candidate: start_from
      when :non_optimized
        list_non_optimized total, candidate: start_from
      when :fibers
        list_fibers total, candidate: start_from
      when :native
        Prime.first total
      end
    end
    def list_optimized total, candidate: 2
      primes = []
      while primes.count < total
        prime = next_prime candidate
        primes << prime
        candidate = prime.next
      end
      primes
    end
    def list_fibers total, candidate: 2
      raise ArgumentError unless total.is_a? Integer
      primes = Fiber.new do
        Fiber.yield candidate
        value = candidate.next
        loop do
          Fiber.yield value if is_prime?(value)
          value += candidate
        end
      end
      primes_arr = []
      total.times{ primes_arr << primes.resume }
      primes_arr
    end
    def table total
      table_data = multi list total
      table_data.each do |s|
        puts s.join(" ") + "\n"
      end
    end
    private
      def is_prime? candidate
        # http://stackoverflow.com/questions/5811151/why-do-we-check-upto-the-square-root-of-a-prime-number-to-determine-if-it-is-pri
        # If a number n is not a prime, it can be factored into two factors a and b:
        # n = a*b
        # If both a and b were greater than the square root of n, a*b would be greater than n. 
        # So at least one of those factors must be less or equal to the square root of n, 
        # and to check if n is prime, we only need to test 
        # for factors less than or equal to the square root.
        return false if candidate <= 1
        2.upto Math.sqrt(candidate).to_i do |x|
          return false if (candidate % x).zero?
        end 
        true
      end 
      def multi list
        raise ArgumentError unless list.respond_to? :each
        list.map do |first|
          list.map do |second|
            first * second
          end
        end 
      end
      def next_prime candidate
        candidate = candidate.next until is_prime?(candidate)
        candidate
      end
      def next_primes_fibers first_prime
        primes = Fiber.new do
          Fiber.yield first_prime
          value = first_prime.next
          loop do
            Fiber.yield value if is_prime?(value)
            value += first_prime
          end
        end
      end
  end
end
