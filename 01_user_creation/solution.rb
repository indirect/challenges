class User < ActiveRecord::Base
  validates_presence_of :email
end

class UsersController < ActionController::Base
  def create
    User.create!(user_params)
    render text: "You're signed up!"
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :username)
  end
end
