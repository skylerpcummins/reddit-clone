class RemoveForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key :subs, column: :moderator_id
    remove_foreign_key :posts, :subs
    remove_foreign_key :posts, column: :author_id
  end
end
