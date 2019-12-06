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
    Bookmark.create params[:title], params[:url]
    redirect '/bookmarks'
  end

  post '/bookmarks/delete' do
    Bookmark.delete params[:id]
    redirect '/bookmarks'
  end

  get '/bookmarks/update' do
    @bookmark = Bookmark.find_by_id(params[:id])
    erb :update
  end

  post '/bookmarks/update' do
    Bookmark.update(params[:id], params[:title], params[:url])
    redirect '/bookmarks'
  end
end
