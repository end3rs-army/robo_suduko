class Puzzle

  attr_reader :original_puzzle

  def initialize(filename)
    split_puzzle(read_puzzle(filename))
  end

  def read_puzzle(filename)
    File.open("./puzzles/#{filename}").readlines.map { |row| row }
  end

  def split_puzzle(sudoku_puzzle)
    @original_puzzle = sudoku_puzzle.join('').delete("\n").split('')
  end

  def print_puzzle
    system 'clear'
    print "\n\t\t== SUDOKU PUZZLE ==\n\n"
    print "\t\t"
    original_puzzle.each.with_index do |number, index|
      print "#{number} "
      print "\n\t\t" if (index+1)%9 == 0
    end
  end

end