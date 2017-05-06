class PasswordResetsController < ApplicationController
  def show
    @user = User.find_by(token: params[:id])
    if !@user
      redirect_to expired_token_path
    end
  end

  def create
    @user = User.find_by(token: params[:token])
    if @user
      permitted_params = params.require(:user).permit(:password, :password_confirmation)
      @user.password = permitted_params['password']
      @user.password_confirmation = permitted_params['password_confirmation']
      if @user.save
        @user.update_column(:token, nil)
        flash[:notice] = 'You have successfully changed your password, please sign in now.'
        redirect_to sign_in_path
      else
        @errors = @user.errors
        flash[:error] = 'Please fix the following errors:'
        render :show
      end
    else
      redirect_to expired_token_path
    end
  end

  def expired_token
  end
end
