module Ahoy
  class Event < ActiveRecord::Base
    include Ahoy::Properties

    self.table_name = "ahoy_events"

    belongs_to :visit
    belongs_to :user

    scope :group_type, -> { group("properties->>'type'") }
    scope :group_status, -> { group("properties->>'status'") }
    scope :group_day, -> { group_by_day(:time, range: 1.week.ago..Time.now) }
    scope :cards, -> { where("name = 'Card'") }
  end
end
