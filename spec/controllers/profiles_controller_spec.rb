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
end
