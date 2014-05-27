require_relative '../table'

describe Table do
  before do
    @content = [[1,2],[3,4]]
    @header = ["a","b"]
    @table = Table.new @content, @header, @header
    $stdout = StringIO.new
  end
  context '#print' do
    before do
      @table_output = <<-EOF.gsub(/^ {8}/,'')
          a b
        a 1 2
        b 3 4
      EOF
    end
    it 'prints the table with header and the first row' do
      @table.print
      expect($stdout.string).to eq(@table_output)
    end
  end
  after :all do
    $stdout = STDOUT
  end
end
