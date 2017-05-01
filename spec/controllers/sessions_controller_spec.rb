require 'rails_helper'

describe SessionsController do
  describe 'POST create' do
    context 'with valid credentials' do
      let(:lily) { Fabricate(:user) }

      it 'sets the session to the authenticated user' do
        post :create, params: { username: lily.username, password: lily.password }
        expect(session[:user_id]).to eq(lily.id)
      end

      it 'redirects to the home path' do
        post :create, params: { username: lily.username, password: lily.password }
        expect(response).to redirect_to home_path
      end

      it 'shows the success message' do
        post :create, params: { username: lily.username, password: lily.password }
        expect(flash[:notice]).not_to be_nil
      end
    end

    context 'with invalid credentials' do
      it 'redirects to the sign in page' do
        post :create, params: { username: 'user', password: 'pass' }
        expect(response).to redirect_to sign_in_path
      end

      it 'does not set the user in the session' do
        post :create, params: { username: 'user', password: 'pass' }
        expect(session[:user_id]).to be_nil
      end

      it 'sets the error message' do
        post :create, params: { username: 'user', password: 'pass' }
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET destroy' do
    before { session[:user_id] = Fabricate(:user).id }

    it 'clears the session for the user' do
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the home path' do
      get :destroy
      expect(response).to redirect_to home_path
    end

    it 'sets the notice' do
      get :destroy
      expect(flash[:notice]).to be_present
    end
  end
end
