class StatisticsController < ApplicationController
  include Pundit
  skip_after_action :track_action

  def index
    authorize :statistics, :index?
  end

  def card_actions
    actions = Ahoy::Event.where("name = 'Card'").group("properties->>'type'").count
    render json: actions
  end

  def visits_per_day
    visits = Visit.group_by_day(:started_at, range: 1.week.ago..Time.now).count
    render json: visits
  end

  def results_review_cards
    results = Ahoy::Event.where("name = 'Card' and properties->>'type' = 'review'").group("properties->>'status'").
                group_by_day(:time, range: 1.week.ago..Time.now).count
    render json: results.chart_json
  end

  def visits_from_countries
    render json: Visit.group(:country).count
  end
end
