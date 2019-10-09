# frozen_string_literal: true

class RepeatedIpsController < ApplicationController
  def index
    res = ActiveRecord::Base.connection.execute <<~SQL
      SELECT DISTINCT login, pp.author_ip FROM
        (SELECT COUNT(p.user_id), p.author_ip FROM
          (SELECT DISTINCT user_id, author_ip FROM posts) as p
        GROUP BY p.author_ip ORDER BY p.author_ip) as pp
      LEFT JOIN posts ON posts.author_ip = pp.author_ip
      LEFT JOIN users ON users.id = user_id
      WHERE pp.count > 1 ORDER BY pp.author_ip
    SQL

    result = res.to_a.group_by { |row| row['author_ip'] }.transform_values { |val| val.map { |v| v['login'] } }

    render json: result
  end
end
