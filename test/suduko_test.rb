require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/cracker'
require_relative '../lib/board'

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
  
end
