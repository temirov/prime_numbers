require 'benchmark'
require_relative '../prime_multi'

Benchmark.bm do |r| 
  r.report "Find prime numbers using native Prime class" do
    100000.times do
      i = +1 
      PrimeMulti.list i, method: :native
    end
  end

  r.report "Find prime numbers using non-optimized while break cycle" do
    100000.times do
      i = +1 
      PrimeMulti.list i, method: :non_optimized
    end
  end

  r.report "Find prime numbers using optimized while break cycle" do
    100000.times do
      i = +1 
      PrimeMulti.list i, method: :optimized
    end
  end

  r.report "Find prime numbers using Fiber iterations" do
    100000.times do
      i = +1 
      PrimeMulti.list i, method: :native
    end
  end
end
