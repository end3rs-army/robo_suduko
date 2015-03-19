require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/cell'
require_relative '../lib/board'
require_relative '../lib/board'
require_relative '../lib/sudoku_solver'

class CellTest < Minitest::Test

  def test_it_can_find_its_position
    cell = Cell.new(1, 22)
    assert_equal 2, cell.row    
    assert_equal 4, cell.column
    assert_equal 1, cell.square
  end

  def test_if_a_cell_knows_if_it_is_immutable
    cell = Cell.new(1, 5)
    assert cell.immutable
  end

  def test_if_a_cell_knows_if_it_is_not_immutable
    cell = Cell.new(0, 5)
    refute cell.immutable
  end

  def test_the_solver_initializes_an_array_of_cells
    puzzle = Puzzle.new("../puzzles/puzzle_0.txt").original_puzzle
    solver = SudokuSolver.new(puzzle)
    assert_equal Cell, solver.guess_puzzle[0].class
    assert_equal 81, solver.guess_puzzle.size
    assert_equal 4, solver.guess_puzzle[36].row
  end

  def test_it_can_return_row_column_square_data
    puzzle = Puzzle.new("../puzzles/puzzle_0.txt").original_puzzle
    solver = SudokuSolver.new(puzzle)
    cell = solver.guess_puzzle[0]
    assert_equal [8,2,6,5,9,4,3,1,7], solver.row_data(cell.row)
    assert_equal [8,7,3,1,9,2,5,4,6], solver.column_data(cell.column)
    assert_equal [8,2,6,7,1,5,3,9,4], solver.square_data(cell.square)
  end

end