# frozen_string_literal: true

class AddAuthorToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :author, :string, default: 'ExampleUser'
  end
end
