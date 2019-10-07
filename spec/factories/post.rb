# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    sequence(:title) { |n| "Test title N#{n}" }
    sequence(:body) { |n| "Test body N#{n}" }
    author_ip { "15.52.45.#{rand(2..10)}" }
  end
end
