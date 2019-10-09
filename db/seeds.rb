# frozen_string_literal: true

USERS_COUNT = 120_000
IPS_COUNT = 60
POSTS_COUNT = 220_000
MAX_POSTS_RATINGS_COUNT = 5

# USERS

users = FactoryBot.build_list :user, USERS_COUNT
User.import users

puts "#{USERS_COUNT} users were created!"

# POSTS

ips = Array.new(IPS_COUNT) { |n| "10.10.10.#{n + 2}" }

posts = Array.new POSTS_COUNT do
  user = users.sample
  ip = ips.sample

  FactoryBot.build :post, user: user, author_ip: ip
end

post_import_result = Post.import posts

puts "#{POSTS_COUNT} posts were created!"

# RATINGS

MAX_STORED_RECORDS = 10_000

@ratings = Array.new MAX_STORED_RECORDS + MAX_POSTS_RATINGS_COUNT
@ratings_count = 0
@imported_ratings_count = 0

def add_ratings(new_ratings)
  new_ratings.each do |rating|
    @ratings[@ratings_count] = rating
    @ratings_count += 1
  end

  import_ratings if @ratings_count >= MAX_STORED_RECORDS
end

def import_ratings
  Rating.import @ratings[0...@ratings_count]

  @imported_ratings_count += @ratings_count
  @ratings_count = 0
end

post_import_result.ids.each do |post_id|
  ratings = FactoryBot.build_list :rating, rand(0..MAX_POSTS_RATINGS_COUNT), post_id: post_id

  add_ratings ratings
end

import_ratings

puts "#{@imported_ratings_count} ratings were created!"
