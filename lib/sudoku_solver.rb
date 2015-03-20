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

  def available_numbers(used_values)
    possible_numbers = (0..9).reject do |check_num| 
      used_values.any? do |value| 
        value == check_num
      end
    end
  end

  def find_available_numbers
    guess_puzzle.each do |cell|
      if cell.value == 0
        used_numbers = board_data(cell)
        cell.possibles = available_numbers(used_numbers)
      end
    end 
  end

  def assign_possible_values
    guess_puzzle.each do |cell|
      if cell.possibles.size == 1 
        cell.value = cell.possibles[0]
      elsif cell.possibles.size == 0
        cell.value = 0
      end
    end
  end

  def next_guess
    guess_puzzle.select do |cell|
      cell.possibles.size > 1 && cell.value == 0
    end
  end

  def get_cell(cells_to_guess)
    cells_to_guess.sort_by do |cell| 
      cell.possibles.size
    end.first
  end

  def assign_guess_value(cell_to_assign)
    if cell_to_assign.possibles == []
      cell_to_assign.value = 0
    else  
      cell_to_assign.value = cell_to_assign.possibles.sample
    end
  end

  def board_data(cell)
    (Board.row_data(cell.row,       guess_puzzle) + 
     Board.column_data(cell.column, guess_puzzle) + 
     Board.square_data(cell.square, guess_puzzle)).uniq
  end

  def solve_puzzle
    while true  
      find_available_numbers
      assign_possible_values
      cells_to_guess = next_guess
      break if cells_to_guess == []
      cell_to_assign = get_cell(cells_to_guess)
      assign_guess_value(cell_to_assign)
    end

  end

end


if __FILE__ == $0

 puzzle = Puzzle.new("../puzzles/puzzle_8.txt").original_puzzle
 suduko = SudokuSolver.new(puzzle)
 suduko.solve_puzzle



end