require 'optparse'
require_relative 'prime_multi'

class CommandLine
  def self.parse args
    options = Struct.new(:total).new(10)

    opts = OptionParser.new do |opts|
      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-t", "--total TOTAL", Numeric, "Number of prime numbers to print") do |total|
        options.total = total
      end

      opts.on_tail('-h', '--help', 'Display this screen') do
        puts opts
        exit
      end
    end

    begin      
      opts.parse! args
      options
    rescue OptionParser::MissingArgument, OptionParser::InvalidOption => e
      puts e
      puts opts
      exit 1
    end
  end
end

options = CommandLine.parse(ARGV)
puts "Printing multiplication table for first #{options.total} prime numbers"
PrimeMulti.table options.total
