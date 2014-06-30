class StripeCharge

  attr_reader :error_message, :response

  def initialize(options={})
    @response = options[:response]
    @error_message = options[:error_message]
  end

  def self.create(options={})

    #Stripe.api_key = Setting.stripe.secret_key
    Stripe.api_key = 'sk_test_pCZIG0qP8mLQCBXabYuUEUcB'
    
    begin
      response = Stripe::Charge.create(
        amount: options[:amount],
        currency: "usd",
        card: options[:card],
        description: options[:description]
        )
      new(:response => response)
    rescue Stripe::CardError => e
      new(:error_message => e.message)
    end
  end

  def successful?
    @response.present?
  end

end