class ParseCardsJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, options)
    ParseCards.new(User.find(user_id), options).call
  end
end
