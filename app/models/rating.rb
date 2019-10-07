# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :post

  validates :value,
            presence: true,
            numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }
end

# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ratings_on_post_id  (post_id)
#
