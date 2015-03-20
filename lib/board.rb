class Board

  def self.square_index
    [[ 0,  1,  2,  9, 10, 11, 18, 19, 20],
     [ 3,  4,  5, 12, 13, 14, 21, 22, 23],
     [ 6,  7,  8, 15, 16, 17, 24, 25, 26],
     [27, 28, 29, 36, 37, 38, 45, 46, 47],
     [30, 31, 32, 39, 40, 41, 48, 49, 50],
     [33, 34, 35, 42, 43, 44, 51, 52, 53],
     [54, 55, 56, 63, 64, 65, 72, 73, 74],
     [57, 58, 59, 66, 67, 68, 75, 76, 77],
     [60, 61, 62, 69, 70, 71, 78, 79, 80]]
  end  

  def self.row_index
    [[ 0,  1,  2,  3,  4,  5,  6,  7,  8],
     [ 9, 10, 11, 12, 13, 14, 15, 16, 17],
     [18, 19, 20, 21, 22, 23, 24, 25, 26],
     [27, 28, 29, 30, 31, 32, 33, 34, 35],
     [36, 37, 38, 39, 40, 41, 42, 43, 44],
     [45, 46, 47, 48, 49, 50, 51, 52, 53],
     [54, 55, 56, 57, 58, 59, 60, 61, 62],
     [63, 64, 65, 66, 67, 68, 69, 70, 71],
     [72, 73, 74, 75, 76, 77, 78, 79, 80]] 
  end  
    
  def self.column_index  
    [[ 0,  9, 18, 27, 36, 45, 54, 63, 72],
     [ 1, 10, 19, 28, 37, 46, 55, 64, 73],
     [ 2, 11, 20, 29, 38, 47, 56, 65, 74],
     [ 3, 12, 21, 30, 39, 48, 57, 66, 75],
     [ 4, 13, 22, 31, 40, 49, 58, 67, 76],
     [ 5, 14, 23, 32, 41, 50, 59, 68, 77],
     [ 6, 15, 24, 33, 42, 51, 60, 69, 78],
     [ 7, 16, 25, 34, 43, 52, 61, 70, 79],
     [ 8, 17, 26, 35, 44, 53, 62, 71, 80]]
  end

  def self.square_reference
    { 0 => 0,  1 => 3,  2 => 6, 
      3 => 27, 4 => 30, 5 => 33,
      6 => 54, 7 => 57, 8 => 60 } 
  end

  def self.what_square_am_i_in(index)
    your_square = square_index.each_with_index do |square, square_index|
      square.select do |position| 
        return square_index if position == index
      end
    end
  end

  def self.what_row_am_i_in(index)
    your_row = row_index.each_with_index do |row, row_index|
      row.select do |position|
        return row_index if position == index 
      end
    end
  end

  def self.what_column_am_i_in(index)
    your_column = column_index.each_with_index do |column, column_index|
      column.select do |position|
        return column_index if position == index 
      end
    end
  end

  def self.row_data(row_number, puzzle)
    start = row_number * 9
    (start..start+8).map { |index| puzzle[index].value.to_i }
  end

  def self.column_data(column_number, puzzle)
    (0..8).map do |index| 
      puzzle[column_number + (index * 9)].value.to_i
    end
  end

  def self.square_data(square_number, puzzle)
    square_start = square_reference[square_number].to_i
    square = []
    (0..2).map do |line|
      (0..2).map do |index|
        square << puzzle[square_start + (index+line*9)].value.to_i
      end
    end
    square
  end

end