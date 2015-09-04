require "../devpoll"

module Devpoll
  adapter = ActiveRecord::Registry
    .adapter("configured")
    .build("polls", "id", ["slug", "content"])

  conn = adapter.connection

  conn.query("CREATE TABLE IF NOT EXISTS polls(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(50),
    content VARCHAR(400)
  )")

  slug = "ruby-average-method-length"
  unless poll = Models::Poll.find_by_slug(slug)
    poll = Models::Poll.create({
      "slug" => slug,
      "content" => "What is the average method length in the code you write in Ruby?",
    })
  end

  conn.query("CREATE TABLE IF NOT EXISTS answers(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    poll_id INT,
    value VARCHAR(50),
    voted INT
  )")

  ["< 2", "2-3", "3-5", "5-10", "10-15", "> 15"].each do |value|
    unless Models::Answer.find_by_value(value, within: poll)
      Models::Answer.create({
        "poll_id" => poll.id,
        "value" => value,
        "voted" => 0,
      })
    end
  end

  conn.close
end
