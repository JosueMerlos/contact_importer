class Contact < ApplicationRecord

  before_validation :set_franchise
  before_validation :set_credit_card_last_digits

  validates :user_id, presence: true

  validates :name, presence: true,
                   length: { minimum: 3 },
                   format: { with: /\A[a-zA-Z \s \-]+\z/ }
  
  validates :date_of_birth, presence: true
  
  validates :phone, presence: true
  
  validates :address, presence: true
  
  validates :credit_card, presence: true, credit_card_number: { brands: [:amex, :diners, :discover, :jcb, :mastercard, :visa] }

  validates :franchise, presence: true,
                        inclusion: { in: ['American Express', 'Diners Club', 'Discover', 'JCB', 'MasterCard', 'Visa'] }

  validates :credit_card_last_digits, presence: true

  has_secure_password :credit_card

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ }

  validate :validate_phone_number

  belongs_to :user

  scope :by_user, ->(user_id) { where(user_id: user_id) }

  private

  def set_franchise
    detector = CreditCardValidations::Detector.new(credit_card)
    self.franchise = detector.brand_name
  end

  def set_credit_card_last_digits
    self.credit_card_last_digits = credit_card.try(:last, 4)
  end

  def validate_phone_number
    return true if is_valid_phone_number?

    errors.add(:phone, 'The phone number is not valid!')
  end

  def is_valid_phone_number?
    return false if phone.nil?

    code_number = phone.try(:to, 5).try(:strip)
    number = phone.try(:from, 6).try(:strip)
    return false unless code_number.match?(/^[(][+]\d{2}[)]/)

    number.gsub(' ', '-').match?(/\d{3}-\d{3}-\d{2}-\d{2}/)
  end

end
