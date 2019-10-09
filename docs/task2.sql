WITH min_groups_ids AS (
  SELECT
    u3.id AS min_id,
    u3.group_id,
    RANK() OVER(ORDER BY u3.id) AS rank
  FROM (
    SELECT
      u.id,
      MIN(u2.id) AS nearest_id,
      u.group_id
    FROM users u
    LEFT JOIN users u2 ON u2.group_id = u.group_id AND u2.id <= u.id
    WHERE u2.id >= u.id - 1
    GROUP BY u.id, u.group_id
    ORDER BY u.id
  ) u3
  WHERE u3.id = u3.nearest_id
), max_groups_ids AS (
  SELECT
    ranked_users.group_id,
    MAX(ranked_users.id) AS max_id,
    ranked_users.rank
  FROM (
    SELECT
      u5.id,
      MAX(min_groups_ids.rank) AS rank,
      u5.group_id
    FROM users u5
    LEFT JOIN min_groups_ids ON min_groups_ids.group_id = u5.group_id AND min_groups_ids.min_id <= u5.id
    GROUP BY u5.id, u5.group_id
    ORDER BY u5.id
  ) ranked_users
  GROUP BY ranked_users.rank, ranked_users.group_id
  ORDER BY ranked_users.rank
)
SELECT
  max_groups_ids.group_id,
  min_groups_ids.min_id,
  max_groups_ids.max_id - min_groups_ids.min_id + 1 AS count
FROM max_groups_ids
INNER JOIN min_groups_ids ON min_groups_ids.rank = max_groups_ids.rank
ORDER BY min_groups_ids.min_id;
