# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Block.destroy_all
Card.destroy_all

require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://www.learnathome.ru/blog/100-beautiful-words'))

admin = User.create!(email: 'admin@example.com', password: 12345, password_confirmation: 12345, admin: true, locale: 'ru')
block = admin.blocks.create!(title: 'First block')

doc.search('//table/tbody/tr').each do |row|
  original = row.search('td[2]')[0].text.downcase
  translated = row.search('td[1]')[0].text.downcase
  admin.cards.create!(block: block, original_text: original, translated_text: translated, review_date: 3.days.from_now, interval: 1, repeat: 1, efactor: 2.5, quality: 5, attempt: 1)
end
