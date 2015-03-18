require_relative './sudoku_solver'
require_relative './puzzle'

class Cracker

  attr_accessor :good_solution
  attr_reader   :puzzle

  def initialize(filename)
    @puzzle = Puzzle.new(filename).original_puzzle
  end

  def find_solution
    solver = SudokuSolver.new(puzzle)
    solution = solver.solve_puzzle
  end

  def correct_solution?(solution)
    @good_solution = solution.none? { |value| value.to_i == 0 }
  end

end