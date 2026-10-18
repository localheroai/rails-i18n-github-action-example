Team = Data.define(:name, :seats, :members) do
  def seats_left
    seats - members.size
  end
end
