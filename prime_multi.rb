class PrimeMulti
  class << self
    def list total, first_prime: 2
      raise ArgumentError unless total.is_a? Integer
      primes = []
      possible_prime = first_prime
      while primes.count < total
        j = first_prime
        while j <= possible_prime
          break if (possible_prime % j).zero?
          j += 1
        end
        primes << possible_prime if j == possible_prime
        possible_prime += 1
      end
      primes
    end
    def table total
      table_data = multi list total
      table_data.each do |s|
        puts s.join(" ") + "\n"
      end
    end
    private
      def multi list
        raise ArgumentError unless list.respond_to? :each
        list.map do |first|
          list.map do |second|
            first * second
          end
        end 
      end
  end
end
