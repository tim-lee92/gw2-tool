require 'rails_helper'

describe StripeWrapper::Charge do
  before do
    StripeWrapper.set_api_key
  end

  let(:token) do
    Stripe::Token.create(
      card: {
        number: card_number,
        exp_month: 12,
        exp_year: 2023,
        cvc: 123
      }
    ).id
  end

  context 'with valid card' do
    let(:card_number) { '4242424242424242' }
    it 'charges the card successfully' do
      response = StripeWrapper::Charge.create(amount: 1000, source: token)
      expect(response).to be_successful
    end
  end

  context 'with invalid card' do
    let(:card_number) { '4000000000000002' }

    it 'does not charge the card successfully' do
      response = StripeWrapper::Charge.create(amount: 1000, source: token)
      expect(response).not_to be_successful
    end

    it 'contains an error message' do
      response = StripeWrapper::Charge.create(amount: 1000, source: token)
      expect(response.error_message).not_to be_nil
    end
  end
end
