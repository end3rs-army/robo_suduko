require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/cracker'
require_relative '../lib/board'
require_relative '../lib/sudoku_solver'
require_relative '../lib/cracker'

class SudukoTest < Minitest::Test

  def test_it_can_read_in_a_puzzle
    puzzle = Puzzle.new("../puzzles/puzzle_test.txt")
    assert_equal %w[8 2 6 5 9 4 3 1 7], puzzle.original_puzzle
  end

  def test_it_initializes_a_board
    board = Board.new
    assert_equal [0,1,2,9,10,11,18,19,20], board.square_index[0]
    assert_equal [0,1,2,3,4,5,6,7,8], board.row_index[0]
    assert_equal [0,9,18,27,36,45,54,63,72], board.column_index[0]
    assert_equal 57, board.square_reference[7]
  end

  def test_it_can_find_what_square_the_index_is_in
    board = Board.new
    assert_equal 8, board.what_square_am_i_in(70)
  end

  def test_it_can_find_what_row_the_index_is_in
    board = Board.new
    assert_equal 7, board.what_row_am_i_in(66)
  end

  def test_it_can_find_what_column_the_index_is_in
    board = Board.new
    assert_equal 4, board.what_row_am_i_in(40)
  end
  
  def test_it_can_find_row_data
    puzzle = Puzzle.new("../puzzles/puzzle_0.txt").original_puzzle
    suduko = SudokuSolver.new(puzzle)
    assert_equal [8,2,6,5,9,4,3,1,7], suduko.row_data(1)
  end

  def test_it_can_find_column_data
    puzzle = Puzzle.new("../puzzles/puzzle_0.txt").original_puzzle
    suduko = SudokuSolver.new(puzzle)
    assert_equal [2,1,9,6,4,5,3,8,7], suduko.column_data(1)
  end

  def test_it_can_find_square_data
    puzzle = Puzzle.new("../puzzles/puzzle_0.txt").original_puzzle
    suduko = SudokuSolver.new(puzzle)
    assert_equal [8,2,6,7,1,5,3,9,4], suduko.square_data(1)
  end

  def test_it_gives_a_random_number_of_available_digits
    puzzle = Puzzle.new("../puzzles/puzzle_0.txt").original_puzzle
    suduko = SudokuSolver.new(puzzle)
    assert_equal 5, suduko.random_digit_spitter([0,1,2,3,4,6,7,8,9])
  end

  def test_it_can_guess_a_number
    puzzle = Puzzle.new("../puzzles/puzzle_test2.txt").original_puzzle
    suduko = SudokuSolver.new(puzzle)
    assert_equal 7, suduko.guess_a_number(0)
  end

  def test_it_returns_true_for_a_good_solution
    solution = Puzzle.new("../puzzles/puzzle_solved.txt").original_puzzle
    filename = "../puzzles/puzzle_solved.txt"
    crack = Cracker.new(filename)
    assert crack.correct_solution?(solution)
  end

  def test_it_can_find_a_solution
    filename = "../puzzles/puzzle_solved.txt"
    crack = Cracker.new(filename)
  end

end
