require 'benchmark'
require_relative '../linked_list'

Benchmark.bm do |r| 
  a = [] 
  l = nil

  r.report "Insert into Array" do
    100000.times do
      i = +1 
      a.insert 0,i 
    end
  end

  r.report "Insert into LinkedList" do 
    100000.times do 
      i = +1 
      l = LinkedList.new(i, l)
    end 
  end

  r.report "Reverse an Array" do
    100.times do 
      a.reverse
    end
  end

  r.report "Reverse a LinkedList" do 
    100.times do 
      l.reverse
    end 
  end

  r.report "Convert an Array to a String" do 
    100.times do 
      a.join(' -> ')
    end 
  end

  r.report "Convert a LinkedList to a String" do 
    100.times do 
      l.to_s
    end 
  end
end
