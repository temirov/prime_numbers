class Table < Struct.new(:content, :header, :first_row)
  def print
    raise ArgumentError if (header && header.length != content.first.length) || (first_row && first_row.length != content.first.length)

    if header
      header.insert 0, "  " if first_row
      content.insert 0, header
    end

    if first_row
      content.each_with_index do |row, i|
        row.insert 0, first_row[i] if i > 0
      end
    end

    content.each do |row|
      puts row.join(' ')
    end
  end

  private
    def columns_width
      columns_width = []
      content.each do |first|
        columns_width << 1
        content.each do |second|
          column_width = second.to_s.length
          columns_width.last = column_width if column_width > columns_width.last
        end
      end
      columns_width
    end
end
