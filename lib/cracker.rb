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
    solution = solver.guess_puzzle
  end

  def correct_solution?(solution)
    checker = SudokuSolver.new(puzzle)
    checker.guess_puzzle = solution
    @good_solution = checker.guess_puzzle.all? do |cell| 
      checker.row_data(cell.row).uniq.size == 9 && checker.row_data(cell.row).include?(0) == false
      checker.column_data(cell.column).uniq.size == 9 && checker.column_data(cell.column).include?(0) == false
      checker.square_data(cell.square).uniq.size == 9 && checker.square_data(cell.square).include?(0) == false
    end 
  end

end