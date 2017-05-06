require 'rails_helper'

describe ForgotPasswordsController do
  after { ActionMailer::Base.deliveries.clear }

  describe 'POST create' do
    context 'with an existing email address' do
      let(:lily) { Fabricate(:user) }
      it 'sends an email' do
        post :create, params: { email: lily.email }
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it 'sends an email to the provided email address' do
        post :create, params: { email: lily.email }
        expect(ActionMailer::Base.deliveries.last.to).to eq([lily.email])
      end

      it 'sets the user' do
        post :create, params: { email: lily.email }
        expect(assigns(:user)).to eq(lily)
      end

      it 'sets a token for the user' do
        post :create, params: { email: lily.email }
        expect(User.first.token).to be_present
      end

      it 'redirects to the sign in path' do
        post :create, params: { email: lily.email }
        expect(response).to redirect_to(sign_in_path)
      end

      it 'sets the notice' do
        post :create, params: { email: lily.email }
        expect(flash[:notice]).to eq('Check your email for instructions to reset your password.')
      end
    end

    context 'with an unexisting email address' do
      it 'renders the :new template' do
        post :create, params: { email: 'non_existant_email@example.com' }
        expect(response).to render_template(:new)
      end

      it 'does not send an email' do
        post :create, params: { email: 'non_existant_email@example.com' }
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end

      it 'sets the error' do
        post :create, params: { email: 'non_existant_email@example.com' }
        expect(flash[:error]).to eq('We were not able to locate a user associated with that email address.')
      end
    end
  end

  describe 'GET new_password' do
    let(:lily) { Fabricate(:user) }
  end
end
