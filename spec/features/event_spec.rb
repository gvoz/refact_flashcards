require 'rails_helper'
require 'support/helpers/login_helper.rb'

describe 'review cards' do
  before do
    user = create(:user_with_one_block_and_two_cards)
    user.cards.each do |card|
      card.update_attribute(:review_date, Time.now - 3.days)
    end
    visit trainer_path
    login('test@test.com', '12345', 'Войти')
  end

  it 'incorrect translation' do
    fill_in 'user_translation', with: 'RoR'
    click_button 'Проверить'
    expect(Ahoy::Event.cards.last.properties)
      .to include('type' => 'review', 'status' => 'error')
  end

  it 'correct translation' do
    fill_in 'user_translation', with: 'house'
    click_button 'Проверить'
    expect(Ahoy::Event.cards.last.properties)
      .to include('type' => 'review', 'status' => 'success')
  end

  it 'correct translation distance=1' do
    fill_in 'user_translation', with: 'hous'
    click_button 'Проверить'
    expect(Ahoy::Event.cards.last.properties)
      .to include('type' => 'review', 'status' => 'misprint')
  end

  it 'incorrect translation distance=2' do
    fill_in 'user_translation', with: 'hou'
    click_button 'Проверить'
    expect(Ahoy::Event.cards.last.properties)
      .to include('type' => 'review', 'status' => 'error')
  end
end

describe 'visit controllers' do
  before do
    create(:user)
    visit root_path
    login('test@test.com', '12345', 'Войти')
  end

  it 'blocks' do
    visit blocks_path
    expect(Ahoy::Event.last.name).to eq "Visited: blocks:index"
  end

  it 'cards' do
    visit cards_path
    expect(Ahoy::Event.last.name).to eq "Visited: cards:index"
  end

  it 'trainer' do
    visit trainer_path
    expect(Ahoy::Event.last.name).to eq "Visited: trainer:index"
  end
end
