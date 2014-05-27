require 'pry'

class Table < Struct.new(:content, :header, :first_row)
  def print
    raise ArgumentError if (header && header.length != content.first.length) || (first_row && first_row.length != content.first.length)

    if header
      header.insert 0, " " if first_row
      content.insert 0, header
    end

    if first_row
      content.each_with_index do |row, i|
        row.insert 0, first_row[i] if i > 0
      end
    end

    content.each do |row|
      puts row.map.with_index{ |e,i| 
        padding_for_column = e.to_s.length + (padding[i] - e.to_s.length)
        e.to_s.rjust(padding_for_column) 
      }.join(' ')
    end
  end

  private
    def padding
      content.last.map{ |e| e.to_s.length }
    end
end
