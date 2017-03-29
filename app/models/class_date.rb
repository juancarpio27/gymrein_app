class ClassDate < ApplicationRecord

  self.per_page = 20

  attr_accessor :repeat, :repeat_type

  belongs_to :instructor
  belongs_to :location
  belongs_to :event

  has_many :reservations, dependent: :destroy
  has_many :waiting_lists, dependent: :destroy

  before_save :calculate_finish
  before_create :set_available

  scope :future, -> {where('date > ?',Time.now - 6.hours)}
  scope :past, -> {where('date < ?',Time.now - 6.hours)}

  module Json

    SHOW = {
        include: {
            event: {
                methods: [:logo_url]
            },
            location: {

            },
            instructor: {

            }
        }
    }

    LIST = {
        include: {
            event: {
                methods: [:logo_url]
            },
            location: {

            },
            instructor: {

            }
        }
    }
  end

  def calculate_finish
    if self.date
      self.finish = self.date + self.duration.minutes
    else
      nil
    end
  end

  def set_available
    self.available = self.limit
  end

  def logo_url
    self.event.logo_url
  end

  def new_class
    self.available = self.available - 1
    self.save!
  end

  def recover_class
    self.available = self.available + 1
    self.save!
  end

  def past_class
    date < Time.now - 6.hours
  end

end
