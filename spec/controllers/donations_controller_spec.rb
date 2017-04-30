require 'rails_helper'

describe DonationsController do
  describe 'POST create' do
    context 'with valid card' do
      it 'sets the flash notice' do
        Stripe::Charge.create.stub(:create)

        expect(flash[:success]).to be_present
      end
    end
  end
end
