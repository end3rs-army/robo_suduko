require_relative './sudoku_solver'
require_relative './board'
require_relative './puzzle'

class Cracker

  attr_accessor :good_solution
  attr_reader   :puzzle

  def initialize(filename)
    @puzzle = Puzzle.new(filename).original_puzzle
  end

  def find_solution
    solver = SudokuSolver.new(puzzle)
    solver.solve_puzzle
    crack = solver.guess_puzzle
  end

  def correct_solution?(crack)
    if rows?(crack) == true && columns?(crack) == true && squares?(crack) == true
      return true
    else
      return false
    end   
  end

  def rows?(crack)
    (0..8).all? do |number| 
      row = Board.row_data(number, crack)
      row.uniq.size == 9 && row.include?(0) == false
    end
  end

  def columns?(crack)
    (0..8).all? do |number| 
      column = Board.column_data(number, crack)
      column.uniq.size == 9 && column.include?(0) == false
    end
  end

  def squares?(crack)
    (0..8).all? do |number| 
      square = Board.square_data(number, crack)
      square.uniq.size == 9 && square.include?(0) == false
    end
  end

end