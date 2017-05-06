require 'rails_helper'

describe User do
  it 'is not valid without a username' do
    user = User.new(email: 'jacky@example.com', password: 'password')
    expect(user).not_to be_valid
  end

  it 'is not valid without an email' do
    user = User.new(username: 'jacky', password: 'password')
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user = User.new(username: 'jacky', email: 'jacky@example.com')
    expect(user).not_to be_valid
  end

  it 'is not valid with a duplicate username' do
    User.create(username: 'jacky', email: 'jacky@example.com', password: 'password')
    user2 = User.new(username: 'jacky', email: 'jacky2@example.com', password: 'password')
    expect(user2).not_to be_valid
  end

  it 'is not valid with a duplicate username regardless of case' do
    User.create(username: 'jacky', email: 'jacky@example.com', password: 'password')
    user2 = User.create(username: 'JaCKy', email: 'jacky2@example.com', password: 'password')
    expect(User.count).to eq(1)
  end

  it 'is not valid with a duplicate email regardless of case' do
    User.create(username: 'jacky', email: 'jacky@example.com', password: 'password')
    user2 = User.create(username: 'JaCKy2', email: 'jACKy@example.com', password: 'password')
    expect(User.count).to eq(1)
  end

  it { should validate_confirmation_of(:password) }

  describe 'generate_token' do
    it 'generates a token for the user' do
      lily = Fabricate(:user)
      lily.generate_token
      expect(User.first.token).to be_present
    end
  end
end
