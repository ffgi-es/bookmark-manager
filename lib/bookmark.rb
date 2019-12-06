require 'pg'

class Bookmark
  attr_reader :title, :url

  def initialize(title, url)
    @title = title
    @url = url
  end

  def self.all
    dbname = 'bookmark_manager' + (ENV['RACK_ENV'] == 'test' ? '_test' : '')
    con = PG.connect dbname: dbname, user: ENV['USER']

    rows = con.exec 'SELECT * FROM bookmarks'
    rows.reduce([]) { |res, row| res << Bookmark.new(row['title'], row['url']) }
  ensure
    con.close if con
  end

  def == other
    title == other.title && url == other.url
  end
end
