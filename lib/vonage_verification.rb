class VonageVerification
  def initialize
    @client = Vonage::Client.new(
      api_key: ENV['VONAGE_API_KEY'],
      api_secret: ENV['VONAGE_API_SECRET']
    )
  end

  def send_otp(phone_number)
    response = @client.verify.request(
      number: TO_NUMBER,
      brand: 'Persada Store'
    )

    if response
      return { status: 'OK',  request_id: response.request_id}
    else
      raise "Failed to send OTP"
    end
  end

  def check_otp(phone_number, user_input)
    otp_log = OtpLog.find_by(phone_number: phone_number)
    response = @client.verify.check(
      request_id: otp_log.request_id,
      code: user_input
    )

    if response
      Rails.logger.info "#{response.currency} #{response.price}"
    else
      raise "Failed to check OTP"
    end
  end
end
