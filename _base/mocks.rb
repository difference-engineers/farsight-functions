MOCK_REQUEST = OpenStruct.new
MOCK_RESPONSE = Class.new do
  def write(output)
    puts(output)
  end

  def status=(statuses)
    puts(statuses)
  end
  self
end.new
