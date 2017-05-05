class ForgotPasswordsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(email: params[:email])
    ApplicationMailer.send_password_reset_email(@user).deliver
    flash[:notice] = 'Check your email for instructions to reset your password.'
    redirect_to sign_in_path
  end
end
