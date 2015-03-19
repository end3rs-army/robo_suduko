require_relative './cell'
require_relative './board'
require_relative './puzzle'
require_relative './advanced_logic'

class SudokuSolver

  attr_accessor :guess_puzzle
  attr_reader   :square_reference,
                :original_puzzle,
                :board

  def initialize(puzzle)
    @guess_puzzle = puzzle.map.with_index do |value, index|
      Cell.new(value, index)
    end
  end

  def row_data(row_number)
    start = row_number * 9
    (start..start+8).map { |index| guess_puzzle[index].value.to_i }
  end

  def column_data(column_number)
    (0..8).map do |index| 
      guess_puzzle[column_number + index*9].value.to_i
    end
  end

  def square_data(square_reference)
    square_start = Board.square_reference[square_reference].to_i
    square = []
    (0..2).map do |line|
      (0..2).map do |index|
        square << guess_puzzle[square_start + (index+line*9)].value.to_i
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

  def guess_a_number(cell)
    numbers = (row_data(cell.row) + 
               column_data(cell.column) + 
               square_data(cell.square)).uniq
    random_digit_spitter(numbers)
  end

  def solve_puzzle
    guess_puzzle.each do |cell|
      if cell.value.to_i == 0
        cell.value = guess_a_number(cell)
      end
    end
  end

end