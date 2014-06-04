class Primes
  class << self
    include Enumerable
    
    def each
      2.upto Float::INFINITY do |i|
        yield i if is_prime? i
      end
    end

    private
      def is_prime? candidate
        2.upto(Math.sqrt(candidate).to_i).map{ |x| candidate % x }.none? &:zero?
      end 
  end
end
