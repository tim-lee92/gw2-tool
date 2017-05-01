require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets @user' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST create' do
    context 'successful user sign up' do
      before { post :create, params: { user: Fabricate.attributes_for(:user) } }
      it 'redirects to the sign in page' do
        expect(response).to redirect_to sign_in_path
      end

      it 'creates the user' do
        expect(User.count).to eq(1)
      end

      it 'sets the success message' do
        expect(flash[:notice]).to be_present
      end
    end

    context 'unsuccessful user sign up' do
      before do
        post :create, params: {
          user: {
            username: 'jackeh'
          }
        }
      end

      it 'renders to the :new template' do
        expect(response).to render_template(:new)
      end

      it 'sets @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'sets the error message' do
        expect(flash[:error]).to be_present
      end
    end
  end
end
