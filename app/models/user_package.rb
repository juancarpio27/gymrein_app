class UserPackage < ApplicationRecord

  belongs_to :user
  belongs_to :package
  belongs_to :card
  belongs_to :promotion, optional: true

  self.per_page = 20

  module Json
    SHOW = {
        include: {
            user: {
                methods: [:access_token, :avatar_url]
            }
        }
    }
  end

  def calculate_price
    if promotion.nil?
      package.price
    else
      if promotion.quantity?
        package.price - promotion.amount
      else
        package.price * (1 - promotion.amount/100.to_f)
      end
    end
  end

end
