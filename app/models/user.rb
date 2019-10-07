# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts

  validates :login, presence: true, uniqueness: true
end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_login  (login) UNIQUE
#
