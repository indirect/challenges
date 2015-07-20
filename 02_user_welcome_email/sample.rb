# Problem Statement
#
# Send a welcome email to each newly created user, using
# the UserMailer, and deliver it in the background. Since
# we will now be using the email address given by the user,
# require that the user enter the email address twice to
# confirm it. The email confirmation will be provided in
# `params[:user][:email_confirmation]`.

class UserMailer < ActionMailer::Base
  def self.welcome_email(user)
    mail(to: user.email, subject: 'Thanks for signing up')
  end
end

class User < ActiveRecord::Base
  validates_presence_of :email
  # Ensure that the user has confirmed their email, and that
  # the email address and the confirmation match.
end

class UsersController < ActionController::Base
  def create
    User.create!(user_params)
    # Send an email to the newly created user's confirmed
    # email address, using the UserMailer class.
    render text: "You're signed up!"
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :username)
  end
end
