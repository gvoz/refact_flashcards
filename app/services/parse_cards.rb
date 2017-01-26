class ParseCards
  attr_reader :page, :options, :user

  def initialize(user, options)
    @page = parse_page(options[:url])
    @user = user
    @options = options
  end

  def parse_page(url)
    Nokogiri::HTML(open(url))
  end

  def call
    page.search(options[:search_selector]).each do |row|
      original_text   = row.search(options[:original_selector].rstrip).first.text.downcase
      translated_text = row.search(options[:translated_selector].rstrip).first.text.downcase

      if original_text && translated_text
        user.cards.create!(
          original_text: original_text,
          translated_text: translated_text,
          block_id: options[:block_id],
          review_date: 3.days.from_now
        )
      end
    end
  end
end
