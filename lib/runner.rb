require 'timeout'
require_relative './cracker'
require_relative './puzzle'

class Runner

  attr_accessor :counter,    
                :cracked
  attr_reader   :start_time, 
                :filename

  def initialize(filename)
    @start_time = Time.now
    @filename   = filename
    @counter    = 0
    @cracked    = false
  end

  def crack
    until @cracked == true
      crack = Cracker.new(filename)
      solution = crack.find_solution
      @counter += 1
      @cracked = true if crack.correct_solution?(solution)
    end
    report(solution)
  end

  def report(solution)
    time = Time.now - start_time
    print "\t\t==== SOLUTION ====\n\n" 
    formatter(solution)
    puts "\n\t--#{counter} iterations to crack the puzzle"
    puts "\n\t--#{time.to_i} seconds to crack the puzzle"
    true
  end

  def formatter(solution)
    print "\t\t"
    solution.each.with_index do |cell, index|
      print "#{cell.value} "
      print "\n\t\t" if (index+1)%9 == 0
    end
  end

end

if __FILE__ == $0

   run = Runner.new("../sudoku-sample-puzzles/puzzle_0.txt")
   puzzle = Puzzle.new("../sudoku-sample-puzzles/puzzle_0.txt")  
   puzzle.print_puzzle
   puts "\n"
   yo = gets.chomp
   run.crack
   to = gets.chomp

  Dir.glob("./sudoku-sample-puzzles/*.txt").each do |file|
    
    begin 
      Timeout::timeout(15) {

        run = Runner.new(".#{file}")
        puzzle = Puzzle.new(".#{file}")  
        puzzle.print_puzzle
        puts "\n"
        run.crack

      }

    rescue Timeout::Error
    puts "\tDidn't crack #{file} \n"
    end
    sleep(3)
  end

end






