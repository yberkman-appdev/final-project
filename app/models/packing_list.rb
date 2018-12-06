# == Schema Information
#
# Table name: packing_lists
#
#  id         :integer          not null, primary key
#  item       :string
#  quantity   :integer
#  trip_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PackingList < ApplicationRecord

    
has_one :user, :through => :trip, :source => :user
has_many :trips, :dependent => :destroy


end
