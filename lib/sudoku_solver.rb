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

  def available_numbers(used_values)
    possible_numbers = (0..9).reject do |check_num| 
      used_values.any? do |value| 
        value == check_num
      end
    end
  end

  def find_available_numbers(cell)
    used_numbers = (row_data(cell.row) + 
                    column_data(cell.column) + 
                    square_data(cell.square)).uniq
    cell.possibles = available_numbers(used_numbers)
  end

  def solve_puzzle
    while true  
      guess_puzzle.each do |cell|
        if cell.value == 0
          find_available_numbers(cell)
        end
      end
      
      guess_puzzle.each do |cell|
        if cell.possibles.size == 1 
          cell.value = cell.possibles[0]
        elsif cell.possibles.size == 0
          cell.value = 0
        end
      end
      
      final_order = guess_puzzle.select do |cell|
        cell.possibles.size > 1 && cell.value == 0
      end

      break if final_order == []
      
      cell_to_assign = final_order.sort_by {|cell| cell.possibles.size}.first
      if cell_to_assign.possibles == []
        cell_to_assign.value = 0
      else  
        cell_to_assign.value = cell_to_assign.possibles.sample
      end
    
    end

  end

end


if __FILE__ == $0

 puzzle = Puzzle.new("../puzzles/puzzle_8.txt").original_puzzle
 suduko = SudokuSolver.new(puzzle)
 suduko.solve_puzzle



end