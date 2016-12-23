class Task
  attr_accessor :file, :data

  def initialize
    @file = file
    @data = array
  end
end

class List
  def csv_creator
    CSV.open(@file, "wb") do |csv| 
    @to_do_list = csv  
    end 
  end

  def csv_reader

  end

  def csv_mofifier

  end
end
