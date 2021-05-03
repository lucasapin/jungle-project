require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation examples here
    it 'all fields are fulfilled' do
      @user = User.new(:first_name=> "Diogo", :last_name=> "Pinheiro" , :password => "123456",  :password_confirmation => "123456", :email => "diogupinheiru@hotmail.com")
      @user.valid?
      expect(@user.errors.full_messages.empty?).to be true
    end

    it 'password and password_confirmation should match' do
      @user = User.new(:password => "123456",  :password_confirmation => "123456")
      @user.valid?
      expect(@user.password).to eq(@user.password_confirmation)
    end
  end
  
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'check uniqueness of the email' do
      @user = User.create(:first_name=> "Lucas", :last_name=> "Pinheiro" , :password => "123456",  :password_confirmation => "123456", :email => "lucaspinheiru@hotmail.com")
      @user1 = User.new(:first_name=> "Vivian", :last_name=> "Santos" , :password => "123456",  :password_confirmation => "123456", :email => "lucaspinheiru@hotmail.com")
      @user1.valid?
      expect(@user1.errors.full_messages).to include "Email has already been taken"    
    end

    it 'returns user with right info' do
      @user = User.new(:first_name => 'name', :last_name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'lucas@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('lucas@email.com', 'password1')).to be_truthy
    end

    it 'checks for right email' do
      @user = User.new(:first_name => 'name', :last_name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'lucas@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('sacul@email.com', 'password1')).to be_nil
    end

    it 'email is not case sensitive' do
      @user = User.new(:first_name => 'name', :last_name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'lucas@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('LUCAS@email.com', 'password1')).to be_truthy
    end
    
    it 'trailing and leading spaces email are valid' do
      @user = User.new(:first_name => 'name', :last_name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'lucas@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('  LUCAS@email.com   ', 'password1')).to be_truthy
    end

    it 'checks for right password' do
      @user = User.new(:first_name => 'name', :last_name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('user@email.com', 'Wrongpassword1')).to be_nil
    end
  end
end
