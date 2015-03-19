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

end