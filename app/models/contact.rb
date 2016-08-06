class Contact < ActiveRecord::Base
  validates :email, presence: true
  validates :comment, presence: true
end
