class User < ActiveRecord::Base
  validates_presence_of :email, :email_confirmation
  validates_confirmation_of :email
end

class UserMailer < ActionMailer::Base
  def self.welcome_email(user)
    mail(to: user.email, subject: 'Thanks for signing up')
  end
end

class UsersController < ActionController::Base
  def create
    @user = User.create!(user_params)
    UserMailer.welcome_email(@user).deliver_later
    render text: "You're signed up!"
  end

  private
  def user_params
    params.require(:user).permit(:email, :email_confirmation, :name, :username)
  end
end
