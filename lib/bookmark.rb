require 'pg'

class Bookmark
  attr_reader :title, :url

  def initialize(title, url)
    @title = title
    @url = url
  end

  def == other
    title == other.title && url == other.url
  end

  def self.all
    rows = connect_to_db do |con|
      con.exec 'SELECT * FROM bookmarks'
    end

    rows.reduce([]) { |res, row| res << Bookmark.new(row['title'], row['url']) }
  end

  def self.create title, url
    rows = connect_to_db do |con|
      con.exec "INSERT INTO bookmarks (title,url) VALUES ('#{title}', '#{url}') RETURNING id, title, url"
    end

    Bookmark.new(rows[0]['title'], rows[0]['url'])
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
