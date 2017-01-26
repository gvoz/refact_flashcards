require 'rails_helper'
require 'support/helpers/login_helper.rb'

describe 'load cards' do
  include ActiveJob::TestHelper
  let!(:user) { create(:user_with_one_block_without_cards) }

  before do
    visit load_form_cards_path
    login('test@test.com', '12345', 'Войти')
  end

  it 'create job' do
    expect(enqueued_jobs.size).to eq 0
    fill_in 'card_form_url', with: "https://www.learnathome.ru/blog/100-beautiful-words"
    fill_in 'card_form_search_selector', with: "//table/tbody/tr"
    fill_in 'card_form_original_selector', with: "td[2]"
    fill_in 'card_form_translated_selector', with: "td[1]"
    find('#card_form_block_id').find(:xpath, 'option[1]').select_option
    click_button "Загрузить"
    expect(enqueued_jobs.size).to eq 1
  end
end
