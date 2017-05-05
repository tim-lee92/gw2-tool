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
      it 'renders the :new template'
      it 'does not send an email'
      it 'sets the error'
    end
  end
end
