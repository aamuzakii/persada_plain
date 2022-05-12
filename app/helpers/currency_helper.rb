module CurrencyHelper
  def get_formatted_price(amount)
    Money.new("#{amount.to_i}00".to_i, "IDR").format(no_cents: true)
  end
end