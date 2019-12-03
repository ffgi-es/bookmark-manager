require 'pg'

class Bookmark
  attr_reader :name, :url

  def initialize(name, url)
    @name = name
    @url = url
  end

  def self.all
    con = PG.connect dbname: 'bookmark_manager', user: ENV['USER']
    rows = con.exec 'SELECT * FROM bookmarks'
    rows.reduce([]) { |res, row| res << Bookmark.new(row['id'], row['url']) }
  ensure
    con.close if con
  end

  def == other
    name == other.name && url == other.url
  end
end
