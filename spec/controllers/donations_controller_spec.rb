require 'rails_helper'

describe DonationsController do
  describe 'POST create' do
    context 'with valid card' do
      it 'sets the flash notice' do
        charge = double(:charge)
        allow(charge).to receive(:successful?).and_return(true)
        expect(StripeWrapper::Charge).to receive(:create).and_return(charge)
        post :create, params: { stripeToken: '123', donation_amount: 1234 }
        expect(flash[:notice]).to eq('Thank\'s for your support!')
      end

      it 'redirects to the home page' do
        charge = double(:charge)
        allow(charge).to receive(:successful?).and_return(true)
        expect(StripeWrapper::Charge).to receive(:create).and_return(charge)
        post :create, params: { stripeToken: '123', donation_amount: 1234 }
        expect(response).to redirect_to(home_path)
      end
    end

    context 'with invalid card' do
      it 'sets the error message' do
        charge = double(:charge)
        allow(charge).to receive(:successful?).and_return(false)
        allow(charge).to receive(:error_message).and_return('something')
        expect(StripeWrapper::Charge).to receive(:create).and_return(charge)
        post :create, params: { stripeToken: '123', donation_amount: 1234 }
        expect(flash[:error]).not_to be_nil
      end

      it 'renders the :new template' do
        charge = double(:charge)
        allow(charge).to receive(:successful?).and_return(false)
        expect(StripeWrapper::Charge).to receive(:create).and_return(charge)
        allow(charge).to receive(:error_message).and_return('something')
        post :create, params: { stripeToken: '123', donation_amount: 1234 }
        expect(response).to render_template(:new)
      end
    end
  end
end
