
module Tea
  class Comment < ActiveRecord::Base
    self.table_name = :tea_comments
    self.primary_key = :id

    belongs_to  :author,  class_name: 'Tea::User', foreign_key: 'user_id',  primary_key: 'id'
    has_many    :likes,   ->{order(created_at: :asc)}, class_name: 'Tea::Like', foreign_key: 'id', primary_key: 'id'

    scope :author_by, -> (user) { where(user_id: user.id) }
    scope :commented_for, -> (id) { where(parent_id: id).order(created_at: :asc) }

    def post_date
      self.updated_at
    end

    def self.create_new_comment! parent_id, author, text
      self.create! id: Id.new_id_as_comment, parent_id: parent_id, text: text, user_id: author.id
    end

  end
end
