# frozen_string_literal: true

class RatingsController < ApplicationController
  def create
    rating = Rating.new rating_params

    if rating.save
      avg_rating = Post.find(rating.post_id).avg_rating

      render json: { avg_rating: avg_rating }, status: :created
    else
      render json: { errors: rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.permit(:post_id, :value)
  end
end
