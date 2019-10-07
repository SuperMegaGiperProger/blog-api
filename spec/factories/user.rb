# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "user_#{n}" }
  end
end
