class ProfilesController < ApplicationController
  before_action :require_user_for_profile

  def show
    @user = current_user
  end

  def my_posts
    @user = current_user
  end

  def my_comments
    @user = current_user
  end

  private

  def require_user_for_profile
    if !current_user
      flash[:error] = 'You must be signed in to view your profile.'
      redirect_to home_path
    end
  end
end
