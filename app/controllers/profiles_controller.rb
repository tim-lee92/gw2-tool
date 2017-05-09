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

  def my_donations
    @user = current_user
  end

  def change_password
    @user = current_user
    permitted_params = params.require(:user).permit(:password, :password_confirmation)
    status = old_password_authenticated?(@user, params[:old_password])
    @user.password = permitted_params[:password]
    @user.password_confirmation = permitted_params[:password_confirmation]

    if status && @user.save
      flash[:notice] = 'You have successfully changed your password'
      redirect_to profile_path
    else
      @errors = @user.errors
      flash.now[:error] = 'Please check the following errors below:'
      render :show
    end
  end

  private

  def require_user_for_profile
    if !current_user
      flash[:error] = 'You must be signed in to view your profile.'
      redirect_to home_path
    end
  end

  def old_password_authenticated?(user, password)
    authentication_status = user.authenticate(params[:old_password])

    if !authentication_status
      user.errors.add(:old_password, 'is not correct.')
    end

    authentication_status
  end
end
