require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'password field cannot be empty' do
      @user = User.new(
        first_name: "Saurabh",
        last_name: "Dabas",
        email: "test@test.com",
        password: nil,
        password_confirmation: "@1%2"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is invalid if password cant be confirmed' do
      @user = User.new(
        first_name: "Saurabh",
        last_name: "Dabas",
        email: "test@test.com",
        password: "@1%2",
        password_confirmation: "5123"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is invalid if email already exists' do
      @user = User.new(
        first_name: "Saurabh",
        last_name: "Dabas",
        email: "test@test.com",
        password: "1111",
        password_confirmation: "1111"
      )
      @user2 = User.new(
        first_name: "Saurabh",
        last_name: "Dabas",
        email: "test@test.com",
        password: "2222",
        password_confirmation: "2222"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Email already exists.")
    end

    it 'is invalid if first name is empty' do
      @user = User.new(
        first_name: nil,
        last_name: "Dabas",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("First name cannot be blank.")
    end

    it 'is invalid if last name is empty' do
      @user = User.new(
        first_name: "Saurabh",
        last_name: nil,
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Last name cannot be blank.")
    end

    it 'is invalid if password is too short' do
      @user = User.new(
        first_name: "Saurabh",
        last_name: "Dabas",
        email: "test@test.com",
        password: "123",
        password_confirmation: "123"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password needs to be longer than 4 characters.")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns nil if email and password are nil' do
      expect(User.authenticate_with_credentials(nil, nil)).to eq(nil)
    end

    it 'returns nil if email is invalid' do
      expect(User.authenticate_with_credentials('hello', 'nil')).to eq(nil)
    end

    it 'returns nil if email is nil' do
      expect(User.authenticate_with_credentials(nil, 'nil')).to eq(nil)
    end

    it 'returns nil if password is nil' do
      expect(User.authenticate_with_credentials("Bob@bob.com", nil)).to eq(nil)
    end

    it 'returns a user if email and password are correct' do
      User.new(
        first_name: "Saurabh",
        last_name: "Dabas",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      ).save
      @user = User.authenticate_with_credentials("test@test.com", "1234")
      expect(@user.email).to eq("test@test.com")
    end

    it 'returns a user if email has trailing spaces' do
      User.new(
        first_name: "Saurabh",
        last_name: "Dabas",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      ).save
      @user = User.authenticate_with_credentials("  test@test.com  ", "1234")
      expect(@user.email).to eq("test@test.com")
    end

    it 'returns a user if email is ramdonly capitalized' do
      User.new(
        first_name: "Saurabh",
        last_name: "Dabas",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      ).save
      @user = User.authenticate_with_credentials("teSt@TeST.cOM", "1234")
      expect(@user.email).to eq("test@test.com")
    end


    
  end

end

