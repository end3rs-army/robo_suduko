require_relative './board'

class Cell

  attr_accessor :value
    attr_reader :immutable,
                :index,
                :column,
                :square,
                :row

  def initialize(value, index)
    @immutable = false if value == 0
    @immutable = true  if value != 0  
    @index     = index
    @value     = value.to_i
    @column    = Board.what_column_am_i_in(index)
    @square    = Board.what_square_am_i_in(index)
    @row       = Board.what_row_am_i_in(index)
  end

end