module StripeWrapper
  def self.set_api_key
    Stripe.api_key = ENV['stripe_secret_key']
  end

  class Charge
    attr_reader :status, :response
    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(options={})
      StripeWrapper.set_api_key
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: 'usd',
          description: options[:description],
          source: options[:source]
        )
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end
    end

    def successful?
      status == :success
    end

    def error_message
      response.message
    end
  end
end
