class TeamSettingsController < ApplicationController
  def show
    @current_user = Member.new(name: "Maja Lind", role: :admin)
    @team = Team.new(
      name: "Fjord Studio",
      seats: 9,
      pending_invites: 2,
      members: [
        @current_user,
        Member.new(name: "Tomasz Nowak", role: :member),
        Member.new(name: "Lena Fischer", role: :member),
        Member.new(name: "Sam Okafor", role: :member)
      ]
    )
  end
end
