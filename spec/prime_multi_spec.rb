require 'prime'
require 'spec_helper'
require_relative '../prime_multi'

describe PrimeMulti do
  context '.list' do
    it 'raises an error if argument is not an integer' do
      expect{PrimeMulti.list([10])}.to raise_error(ArgumentError)
    end
    it 'returns a list of prime numbers if no method is specified' do
      expect(PrimeMulti.list(10)).to eq(Prime.first(10))
    end
    it 'returns a list of prime numbers using fibers method' do
      expect(PrimeMulti.list(10, method: :fibers)).to eq(Prime.first(10))
    end
    it 'returns a list of prime numbers using non_optimized method' do
      expect(PrimeMulti.list(10, method: :non_optimized)).to eq(Prime.first(10))
    end
    it 'returns a list of prime numbers using optimized method' do
      expect(PrimeMulti.list(10, method: :optimized)).to eq(Prime.first(10))
    end
    it 'returns a list of prime numbers using optimized method' do
      expect(PrimeMulti.list(10, method: :native)).to eq(Prime.first(10))
    end
  end
  context '.multi' do
    before do
      @table = [
        [4, 6, 10, 14, 22, 26, 34, 38, 46, 58], 
        [6, 9, 15, 21, 33, 39, 51, 57, 69, 87], 
        [10, 15, 25, 35, 55, 65, 85, 95, 115, 145], 
        [14, 21, 35, 49, 77, 91, 119, 133, 161, 203], 
        [22, 33, 55, 77, 121, 143, 187, 209, 253, 319], 
        [26, 39, 65, 91, 143, 169, 221, 247, 299, 377],
        [34, 51, 85, 119, 187, 221, 289, 323, 391, 493], 
        [38, 57, 95, 133, 209, 247, 323, 361, 437, 551], 
        [46, 69, 115, 161, 253, 299, 391, 437, 529, 667], 
        [58, 87, 145, 203, 319, 377, 493, 551, 667, 841]
      ]
    end
    it 'returns a multiplication table of the first 10 prime numbers' do
      expect(PrimeMulti.send(:multi, PrimeMulti.list(10))).to eq(@table)
    end
  end
  context '.table' do
    before do
      @table = <<-EOF.gsub(/^ {8}/,'')
        Printing multiplication table for the first 10 prime numbers
        4 6 10 14 22 26 34 38 46 58
        6 9 15 21 33 39 51 57 69 87
        10 15 25 35 55 65 85 95 115 145
        14 21 35 49 77 91 119 133 161 203
        22 33 55 77 121 143 187 209 253 319
        26 39 65 91 143 169 221 247 299 377
        34 51 85 119 187 221 289 323 391 493
        38 57 95 133 209 247 323 361 437 551
        46 69 115 161 253 299 391 437 529 667
        58 87 145 203 319 377 493 551 667 841
      EOF
      @output = `ruby print_prime_table.rb`
    end
    it 'prints a multiplication table of the first 10 prime numbers' do
      expect(@output).to eq(@table)
    end
  end

end
