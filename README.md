# Blog API
## Description

There is a blog with the following entities:
1. User. It has only a login.
2. The post, belongs to the user. It has a title, a body,
an author IP (stored separately for each post).
3. The rating, belongs to the post. It takes a value from 1 to 5.

There is JSON API with the following actions:
1. Create a post. It takes a title and a body of the post
(they can not be empty), a login and an author IP. If there is no author
with such login yet, it will be created. It returns either attributes
of the post with status 200, or validation errors with status 422.
 - `POST /posts` **params:** `title`, `body`, `user_login`, `author_ip`, **returns:** `{ title, body }`
2. Rate a post. It takes the post's ID and value, returns a new
average post rating. Action works correctly for any number of competitive requests to rate the same post.
 - `POST /posts/{post_id}/ratings` **params:** `value`, **returns:** `{ avg_rating }`
3. Get top N posts by average rating. It returns an array of objects with titles and bodies.
 - `GET /top_posts` **params:** `n`, **returns:** array of posts
4. Get a list of IPs, from which several different authors have posted. It returns an array of objects
with following fields: IP and an array of authors logins.
 - `GET /repeated_ips` **returns:** `[{ ip, logins: [...] }, ...]`

#### Seeds
`db/seeds.rb`:
 - Posts > 200K
 - Users > 100K
 - IPs > 50
