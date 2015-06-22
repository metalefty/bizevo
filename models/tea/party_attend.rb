
module Tea
  class PartyAttend < ActiveRecord::Base
    self.table_name = 'tea_party_attends'
    self.primary_key = :id, :user_id

    belongs_to :user, class_name: 'Tea::User', foreign_key: 'user_id', primary_key: 'id'
    belongs_to :party, class_name: 'Tea::Party', foreign_key: 'id', primary_key: 'id'

    scope :attended_for, -> (id) { where(id: id) }
  end
end
