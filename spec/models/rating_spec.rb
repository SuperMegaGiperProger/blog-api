# frozen_string_literal: true

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

require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
  end

  describe 'validations' do
    it { should validate_presence_of(:value) }
    it do
      should validate_numericality_of(:value)
        .only_integer
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(5)
    end
  end
end
