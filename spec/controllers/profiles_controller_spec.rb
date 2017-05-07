require 'rails_helper'

describe ProfilesController do
  describe 'GET show' do
    context 'for authenticated users' do
      it 'sets @user to the current user' do
        lily = Fabricate(:user)
        session[:user_id] = lily.id
        get :show
        expect(assigns(:user)).to eq(lily)
      end
    end

    context 'for unauthenticated users' do
      it 'redirects to the home path' do
        get :show
        expect(response).to redirect_to(home_path)
      end

      it 'sets the error message' do
        get :show
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET my_posts' do
    context 'for authenticated users' do
      it 'sets @user to the current user' do
        lily = Fabricate(:user)
        session[:user_id] = lily.id
        get :my_posts
        expect(assigns(:user)).to eq(lily)
      end
    end

    context 'for unauthenticated users' do
      it 'redirects to the home path' do
        get :my_posts
        expect(response).to redirect_to(home_path)
      end

      it 'sets the error message' do
        get :my_posts
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET my_comments' do
    context 'for authenticated users' do
      it 'sets @user to the current user' do
        lily = Fabricate(:user)
        session[:user_id] = lily.id
        get :my_posts
        expect(assigns(:user)).to eq(lily)
      end
    end

    context 'for unauthenticated users' do
      it 'redirects to the home path' do
        get :my_comments
        expect(response).to redirect_to(home_path)
      end

      it 'sets the error message' do
        get :my_comments
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'POST change_password' do
    context 'for authenticated users' do
      let(:lily) { Fabricate(:user, password: 'password') }
      before { session[:user_id] = lily.id }

      it 'changes the password with a valid old password' do
        patch :change_password, params: {
          old_password: 'password',
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(User.first.authenticate('new_password')).to be_truthy
      end

      it 'does not change the password with an invalid old password' do
        patch :change_password, params: {
          old_password: 'invalid_password',
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(User.first.authenticate('new_password')).to be_falsey
      end

      it 'redirects to the profile path' do
        patch :change_password, params: {
          old_password: 'password',
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(response).to redirect_to(profile_path)
      end

      it 'sets the notice for when password change is successful' do
        patch :change_password, params: {
          old_password: 'password',
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(flash[:notice]).to be_present
      end

      it 'sets the error for when password change is unsuccessful' do
        patch :change_password, params: {
          old_password: 'passw',
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(flash[:error]).to be_present
      end
    end

    context 'for unauthenticated users' do
      it 'redirects to the home path' do
        patch :change_password
        expect(response).to redirect_to(home_path)
      end

      it 'sets the error message' do
        patch :change_password
        expect(flash[:error]).to be_present
      end
    end
  end
end
