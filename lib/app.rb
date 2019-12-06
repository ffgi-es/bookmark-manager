require 'sinatra/base'
require_relative 'bookmark'

class BookmarkManager < Sinatra::Base
  get '/' do
    redirect '/bookmarks'
  end
  
  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post '/bookmarks/add' do
    Bookmark.create params['title'], params['url']
    redirect '/bookmarks'
  end
end
