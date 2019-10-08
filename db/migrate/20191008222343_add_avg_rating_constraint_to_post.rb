# frozen_string_literal: true

class AddAvgRatingConstraintToPost < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :avg_rating, 0
  end
end
