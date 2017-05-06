require 'rails_helper'

describe PasswordResetsController do
  describe 'GET show' do
    context 'with a valid token' do
      let(:lily) { Fabricate(:user) }
      before { lily.generate_token }

      it 'sets @user to the user associated with the token' do
        get :show, params: { id: lily.token}
        expect(assigns(:user)).to eq(lily)
      end
    end

    context 'with an invalid token' do
      it 'redirects to the expired token path' do
        get :show, params: { id: 'invalid_token' }
        expect(response).to redirect_to(expired_token_path)
      end
    end
  end

  describe 'POST create' do
    context 'with a valid token' do
      let(:lily) { Fabricate(:user) }
      let(:params) do

      end
      before { lily.generate_token }

      it 'updates the password' do
        post :create, params: {
          token: lily.token,
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(User.first.authenticate('new_password')).to be_truthy
      end

      it 'expires the token' do
        post :create, params: {
          token: lily.token,
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(User.first.token).to be_nil
      end

      it 'redirects to the sign in path' do
        post :create, params: {
          token: lily.token,
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(response).to redirect_to(sign_in_path)
      end

      it 'sets the success message' do
        post :create, params: {
          token: lily.token,
          user: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
        expect(flash[:notice]).to be_present
      end
    end

    context 'with an invalid token' do
      it 'redirects to the expired token path' do
        post :create, params: { token: 'invalid token', password: 'new_password' }
        expect(response).to redirect_to(expired_token_path)
      end
    end
  end
end
