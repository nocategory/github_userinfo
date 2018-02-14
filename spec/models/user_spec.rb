require 'rails_helper'

RSpec.describe User, :type => :model do
  u = User.new

  it "is valid with valid attributes" do
    u.login = "Something"
    u.name = "Name"
    u.avatar_url = "https://avatars2.githubusercontent.com/u/12294525?v=4"
    u.followers = 101
    u.public_repos = 256
    u.repos_url = "https://api.github.com/users/uppe-r/repos"
    expect(u).to be_valid
  end

  it "is not valid without a login" do
    u.login = nil
    expect(u).to_not be_valid
  end

  it "is valid without a name" do
    u.login = "Someone"
    u.name = nil
    expect(u).to be_valid
  end

  it "is valid without an avatar_url" do
    u.avatar_url = nil
    expect(u).to be_valid
  end

  it "is valid without a followers" do
    u.followers = nil
    expect(u).to be_valid
  end

  it "is valid without a public_repos" do
    u.public_repos = nil
    expect(u).to be_valid
  end

  it "is valid without a repos_url" do
    u.repos_url = nil
    expect(u).to be_valid
  end
end
