class ForgotPasswordsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_token
      ApplicationMailer.send_password_reset_email(@user).deliver
      flash[:notice] = 'Check your email for instructions to reset your password.'
      redirect_to sign_in_path
    else
      flash.now[:error] = 'We were not able to locate a user associated with that email address.'
      render :new
    end
  end
end
