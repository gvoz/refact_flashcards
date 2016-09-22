# class for users
class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :blocks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  belongs_to :current_block, class_name: 'Block'
  before_create :set_default_locale
  before_validation :set_default_locale, on: :create

  accepts_nested_attributes_for :authentications

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :password, confirmation: true, presence: true, length: { minimum: 3 }, if: :password
  validates :password_confirmation, presence: true, if: :password_confirmation
  validates :email, uniqueness: true, presence: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :locale, presence: true,
            inclusion: { in: I18n.available_locales.map(&:to_s),
                    message: 'Выберите локаль из выпадающего списка.' }

  def current_block(block = nil)
    update_attribute(:current_block_id, block.nil? ? nil : block.id)
  end

  private

  def set_default_locale
    self.locale = I18n.locale.to_s
  end
end
