class PrimeMulti
  class << self
    def list total
      raise ArgumentError unless total.is_a? Integer
      primes = []
      first_prime = 2
      possible_prime = first_prime
      count = 1
      while count <= total
        j = first_prime
        while j <= possible_prime
          break if possible_prime % j == 0
          j += 1
        end
        if j == possible_prime
          primes << possible_prime 
          count += 1
        end
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
