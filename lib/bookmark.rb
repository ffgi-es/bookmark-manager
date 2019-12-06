require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url
  end

  def == other
    id = other.id && title == other.title && url == other.url
  end

  def self.all
    rows = connect_to_db do |con|
      con.exec 'SELECT * FROM bookmarks'
    end

    rows.reduce([]) { |res, row| res << Bookmark.new(row['id'], row['title'], row['url']) }
  end

  def self.create title, url
    rows = connect_to_db do |con|
      con.exec "INSERT INTO bookmarks (title,url) VALUES ('#{title}', '#{url}') RETURNING id, title, url"
    end

    Bookmark.new(rows[0]['id'], rows[0]['title'], rows[0]['url'])
  end

  def self.delete id
    connect_to_db do |con|
      con.exec "DELETE FROM bookmarks WHERE id = #{id}"
    end
  end

  def self.find_by_id id
    rows = connect_to_db do |con|
      con.exec "SELECT * FROM bookmarks WHERE id = #{id}"
    end

    Bookmark.new(rows[0]['id'], rows[0]['title'], rows[0]['url'])
  end

  def self.update id, title, url
    rows = connect_to_db do |con|
      con.exec "UPDATE bookmarks SET title='#{title}', url='#{url}' WHERE id=#{id} RETURNING id, title, url"
    end

    Bookmark.new(rows[0]['id'], rows[0]['title'], rows[0]['url'])
  end

  private

  def self.connect_to_db
    dbname = 'bookmark_manager' + (ENV['RACK_ENV'] == 'test' ? '_test' : '')
    con = PG.connect dbname: dbname, user: ENV['USER']

    yield con if block_given?
  ensure
    con.close if con
  end
end

class DuplicateBookmarkError < StandardError
end
