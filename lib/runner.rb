require_relative './cracker'

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
    print "Solution is:\n" 
    formatter(solution)
    puts "\n--#{counter} iterations to crack the puzzle"
    puts "\n--#{time} seconds to crack the puzzle"
    true
  end

  def formatter(solution)
    solution.each.with_index do |cell, index|
      print "#{cell.value}"
      print "\n" if (index+1)%9 == 0
    end
  end

end

if __FILE__ == $0

  run = Runner.new("../puzzles/puzzle_1.txt")
  run.crack

end






