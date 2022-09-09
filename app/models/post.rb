# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :topic
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true

  def replies
    Comment.where('post_id = ? and parent_id == 0', id).order(%w[parent_id id]).group_by { |comment| comment['parent_id'] }
  end

  def comments
    Comment.where('post_id = ? and parent_id != 0').order('id')
  end
end
