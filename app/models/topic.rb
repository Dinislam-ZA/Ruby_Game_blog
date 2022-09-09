# frozen_string_literal: true

class Topic < ApplicationRecord
  has_many :posts
end
