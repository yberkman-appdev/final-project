# == Schema Information
#
# Table name: trips
#
#  id          :integer          not null, primary key
#  destination :string
#  duration    :integer
#  season      :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Trip < ApplicationRecord
    
  validates :user_id, presence: true
  validates :destination, presence: true
  validates :season, presence: true
  validates :duration, presence: true
  validates :duration, :numericality => { :greater_than => 0 }
    


belongs_to :user
has_many :packing_lists, :dependent => :destroy
    
end
