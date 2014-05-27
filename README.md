Write a program that prints out a multiplication table of the first 10 prime numbers.

The program must run from the command line and print one table to STDOUT.

The first row and column of the table should have the 10 primes, with each cell containing the product of the primes for the corresponding row and column.

*Notes:*

- Consider complexity. How fast does your code run? How does it scale? 

  - _Please, see the benchmark. Use `ruby benchmark/benchmark.rb` to run_

- Consider cases where we want N primes.

  - _Please, see print_primes.rb. Use `ruby print_primes.rb -?` and `ruby print_primes.rb -t <n>` to see the output_

- Do not use the Prime class from stdlib (write your own code).

  - _Please, see various implementations in `prime_multi.rb` file_

- Write tests. Try to demonstrate TDD/BDD.

  - _Please, see `spec/prime_multi_spec.rb`. Please, run `rspec` to see if tests are passing_
 
*NB*

I have been using the latest stable version of Ruby, which was 2.1.2 at the moment of writing
