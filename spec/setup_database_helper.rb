require 'pg'

def truncate_bookmarks
  connection = PG.connect dbname: 'bookmark_manager_test', user: ENV['USER']
  connection.exec 'TRUNCATE TABLE bookmarks'
ensure
  connection.close if connection
end
