# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings
end

# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string
#  body          :string
#  author_ip     :inet
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  avg_rating    :float            default("0.0")
#  ratings_sum   :integer          default("0"), not null
#  ratings_count :integer          default("0"), not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
