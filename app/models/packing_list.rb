# == Schema Information
#
# Table name: packing_lists
#
#  id           :integer          not null, primary key
#  item         :string
#  quantity     :integer
#  trip_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  packed       :boolean
#  user_created :boolean
#

class PackingList < ApplicationRecord

validates :item, presence: true
validates :quantity, presence: true
validates :quantity, :numericality => { :greater_than => 0 }
validates :trip_id, :presence => true

validates :packed, inclusion: { in: [true, false] }
validates :user_created, inclusion: { in: [true, false] }



    
has_one :user, :through => :trip, :source => :user
belongs_to :trip

end
