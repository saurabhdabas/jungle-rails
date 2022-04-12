require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'password field cannot be empty' do
      @user = User.new(
        name: "Saurabh",
        email: "test@test.com",
        password: nil,
        password_confirmation: "@1%2"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

  end


end
