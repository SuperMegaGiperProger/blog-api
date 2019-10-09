# frozen_string_literal: true
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
#  index_posts_on_author_ip  (author_ip)
#  index_posts_on_user_id    (user_id)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:ratings) }
  end
end
