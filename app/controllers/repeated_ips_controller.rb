# frozen_string_literal: true

class RepeatedIpsController < ApplicationController
  def index
    res = ActiveRecord::Base.connection.execute <<~SQL
      SELECT DISTINCT users.login, ip_with_count.author_ip FROM
      (
        SELECT COUNT(ip_history.user_id), ip_history.author_ip FROM
          (SELECT DISTINCT user_id, author_ip FROM posts) ip_history
        GROUP BY ip_history.author_ip
        ORDER BY ip_history.author_ip
      ) ip_with_count
      LEFT JOIN posts ON posts.author_ip = ip_with_count.author_ip
      LEFT JOIN users ON users.id = user_id
      WHERE ip_with_count.count > 1
      ORDER BY ip_with_count.author_ip
    SQL

    result = res.to_a
                .group_by { |row| row['author_ip'] }
                .map { |ip, datas| { ip: ip, logins: datas.map { |data| data['login'] } } }

    render json: result
  end
end
