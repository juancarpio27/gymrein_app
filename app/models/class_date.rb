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
        methods: [:logo_url],
        include: {

            event: {
                methods: [:logo_url]
            },
            location: {

            },
            instructor: {
                methods: [:avatar_url]
            }
        }
    }

    LIST = {
        methods: [:logo_url],
        include: {

            event: {
                methods: [:logo_url]
            },
            location: {

            },
            instructor: {
                methods: [:avatar_url]
            }
        }
    }

    MONITOR = {
        methods: [:logo_url, :event, :instructor, :location, :logo_url, :avatar_url],
        include: {

            reservations: {
                methods: [:user, :user_avatar]
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

  def avatar_url
    self.instructor.avatar_url
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
