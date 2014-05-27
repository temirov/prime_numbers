require 'prime'
require_relative 'table'

class PrimeMulti
  class << self
    # NOTE list_non_optimized has 2 nested iterations amounting to O(n^2) complexity
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
    def list total, start_from: 2, method: :fibers
      case method
      when :optimized
        list_optimized total, candidate: start_from
      when :non_optimized
        list_non_optimized total, candidate: start_from
      when :fibers
        list_fibers total, candidate: start_from
      when :native
        Prime.first total
      else
        list_fibers total, candidate: start_from
      end
    end
    # NOTE list_optimized has 2 nested iterations 
    # second iteration is shortened due to optimization
    # resulting in reduced complexity O(n*sqrt(n))
    def list_optimized total, candidate: 2
      primes = []
      while primes.count < total
        prime = next_prime candidate
        primes << prime
        candidate = prime.next
      end
      primes
    end
    # NOTE list_fibers is algorithmically the same as list_optimized 
    # but it works a little faster due to multithreading efficiency of Fibers
    def list_fibers total, candidate: 2
      raise ArgumentError unless total.is_a? Integer
      prime = Fiber.new do
        loop do
          Fiber.yield candidate if is_prime?(candidate)
          candidate += 1
        end
      end
      primes = []
      total.times{ primes << prime.resume }
      primes
    end
    def table total
      primes = list total
      table_data = multi primes

      table = Table.new table_data, primes, primes
      table.print
    end
    private
      # NOTE http://stackoverflow.com/questions/5811151/why-do-we-check-upto-the-square-root-of-a-prime-number-to-determine-if-it-is-pri
      # If a number n is not a prime, it can be factored into two factors a and b:
      # n = a*b
      # If both a and b were greater than the square root of n, a*b would be greater than n. 
      # So at least one of those factors must be less or equal to the square root of n, 
      # and to check if n is prime, we only need to test for factors less than or equal to the square root.
      def is_prime? candidate
        return false if candidate <= 1
        2.upto Math.sqrt(candidate).to_i do |x|
          return false if (candidate % x).zero?
        end 
        true
      end 
      # NOTE multiplication table is O(n^2) 
      def multi list
        raise ArgumentError unless list.respond_to? :each
        list.map do |first|
          list.map do |second|
            first * second
          end
        end 
      end
      def next_prime candidate
        candidate += 1 until is_prime?(candidate)
        candidate
      end
  end
end
