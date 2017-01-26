class ParseCardsJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, options)
    ParseCards.new(User.find(user_id), card_form_params).call
  end
end
