Team = Data.define(:name, :seats, :members, :pending_invites) do
  def seats_left
    seats - members.size
  end
end
