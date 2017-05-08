require 'rails_helper'

describe LandingPagesController do
  it 'sets @gem_exchange' do
    get :home
    expect(assigns(:gem_exchange_for_coins)).not_to be_nil
  end

  it 'sets @gem_exchange to a hash object' do
    get :home
    expect(assigns(:gem_exchange_for_coins)).to be_instance_of(Hash)
  end
end
