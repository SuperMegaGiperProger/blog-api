# frozen_string_literal: true

class AddAvgRatingToPosts < ActiveRecord::Migration[5.2]
  def up
    add_column :posts, :avg_rating, :float
    add_column :posts, :ratings_sum, :bigint, default: 0, null: false
    add_column :posts, :ratings_count, :integer, default: 0, null: false

    execute <<~SQL
      CREATE OR REPLACE FUNCTION update_post_avg_rating()
        RETURNS trigger AS
      $$
      BEGIN
         UPDATE posts SET
           ratings_sum = ratings_sum + NEW.value,
           ratings_count = ratings_count + 1,
           avg_rating = (ratings_sum + NEW.value)::float / (ratings_count + 1)::float
         WHERE id = NEW.post_id;

         RETURN NEW;
      END;
      $$
      LANGUAGE 'plpgsql';

      CREATE TRIGGER after_ratings_insert
        AFTER INSERT
        ON ratings
        FOR EACH ROW
        EXECUTE PROCEDURE update_post_avg_rating();
    SQL
  end

  def down
    remove_column :posts, :avg_rating
    remove_column :posts, :ratings_sum
    remove_column :posts, :ratings_count

    execute <<~SQL
      DROP TRIGGER after_ratings_insert ON ratings;
      DROP FUNCTION update_post_avg_rating();
    SQL
  end
end
