require_relative './board'
require_relative './puzzle'

class SudokuSolver

  attr_accessor :guess_puzzle
  attr_reader   :square_reference,
                :original_puzzle,
                :board

  def initialize(puzzle)
    @guess_puzzle = puzzle
    @board = Board.new
  end

  def row_data(index)
    row_number = board.what_row_am_i_in(index)
    row = find_row(row_number)
  end

  def column_data(index)
    column_number = board.what_column_am_i_in(index)
    column = find_column(column_number)
  end

  def square_data(index)
    square_number = board.what_square_am_i_in(index)
    square = find_square(square_number)
  end

  def find_row(row_number)
    start = row_number * 9
    (start..start+8).map { |index| guess_puzzle[index].to_i }
  end

  def find_column(column_number)
    (0..8).map { |index| guess_puzzle[column_number + index*9].to_i }    
  end

  def find_square(square_index)
    square_start = @board.square_reference[square_index].to_i
    square = []
    (0..2).map do |line|
      (0..2).map do |index|
        square << guess_puzzle[square_start + (index+line*9)].to_i
      end
    end
    square
  end

  def random_digit_spitter(used_values)
    guess = (0..9).reject { |check_num| used_values.any? { |value| value == check_num } }
    if guess == []
      0
    else
      guess.sample
    end
  end

  def guess_a_number(index)
    numbers = (row_data(index) + column_data(index) + square_data(index)).uniq
    random_digit_spitter(numbers)
  end

  def solve_puzzle
    guess_puzzle.each_with_index do |value, index|
      if value.to_i == 0
        guess_puzzle[index] = guess_a_number(index)
      end
    end
  end

end