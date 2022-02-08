require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    user = User.create({
      first_name: "Dickson",
      last_name: "Yu",
      email: "test@test.com",
      password: "test",
      password_confirmation: "test"
    })

    it 'should create valid user' do
      user.save
      expect(User.find_by(last_name: "Yu")).not_to be_nil
    end

    it 'should not save when email is blank' do
      user1 = user
      user1.email = nil
      user1.save
      expect(User.find_by(id: 2)).to be_nil
    end

    it 'should not allow a new user to enter same email + case' do
      user1 = user
      user1.email = "TEST@test.com"
      user1.save
      expect(User.find_by(id: 2)).to be_nil
    end

    it 'should not save without first name' do
      user1 = user
      user1.first_name = nil
      user1.save
      expect(User.find_by(id: 2)).to be_nil
    end

    it 'should not save without last name' do
      user1 = user
      user1.last_name = nil
      user1.save
      expect(User.find_by(id: 2)).to be_nil
    end

    it 'should not save without a password confirmation' do
      user1 = user
      user1.password = nil
      user1.save
      expect(User.find_by(id: 2)).to be_nil
    end

    it 'should have password matching' do
      user.password = "TEST"
      user.password_confirmation = "test"
      user.save
      expect(user.password).not_to eq(user.password_confirmation)
    end

    it 'password must have at least 3 characters' do
      user1 = user
      user1.password = "te"
      user1.password_confirmation = "te"
      user1.save
      expect(User.find_by(id: 2)).to be_nil
    end
  end

  describe '.authenticate_with_credentials' do

    user = User.create({ 
      first_name: "Dickson", 
      last_name: "Yu", 
      email: "testing@test.com", 
      password: "test", 
      password_confirmation: "test"
    })

    it 'should authenticate user when fields are entered correctly' do
      user2 = User.authenticate_with_credentials(user.email, user.password)
      expect(user2).not_to be_nil
    end

    it 'should not authenticate user when password is entered incorrectly' do
      user2 = User.authenticate_with_credentials(user.email, "testing")
      expect(user2).to be_nil
    end

    it 'should not authenticate user is email does not exist' do
      user2 = User.authenticate_with_credentials("testtest@testtest.com", "testing")
      expect(user2).to be_nil
    end

    it "should authenticate the user despite different casing in email" do
      user2 = User.authenticate_with_credentials('TEsting@TESt.cOM', user.password)
      expect(user2).not_to be_nil
    end

    it "should authenticate the user despite spaces being entered around email" do
      user2 = User.authenticate_with_credentials(' testing@test.com ', user.password)
      expect(user2).not_to be_nil
    end


  end



end
