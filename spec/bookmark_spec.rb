require 'bookmark'
require 'pg'

RSpec.describe Bookmark do
  let(:id) { 3 }
  let(:title) { 'Title' }
  let(:url) { 'URL' }
  subject(:bookmark) { Bookmark.new(id, title, url) }

  it 'should have a title' do
    expect(subject).to have_attributes title: title
  end

  it 'should have an id' do
    expect(subject).to have_attributes id: id
  end

  it 'should have a url' do
    expect(subject).to have_attributes url: url
  end

  describe '.all' do
    it 'should return an array of bookmarks' do
      begin
        connection = PG.connect dbname: 'bookmark_manager_test'

        connection.exec "INSERT INTO bookmarks (title, url) VALUES ('Test 1', 'http://www.test_1.com')"
        connection.exec "INSERT INTO bookmarks (title, url) VALUES ('Test 2', 'http://www.test_2.com')"
        connection.exec "INSERT INTO bookmarks (title, url) VALUES ('Test 3', 'http://www.test_3.com')"
      ensure
        connection.close if connection
      end

      bookmarks = Bookmark.all

      titles = ['Test 1', 'Test 2', 'Test 3']
      urls = ['http://www.test_1.com',
              'http://www.test_2.com',
              'http://www.test_3.com']

      bookmarks.each do |bmark|
        expect(bmark).to be_instance_of Bookmark
        expect(titles).to include bmark.title
        expect(urls).to include bmark.url
      end
    end
  end

  describe '.create' do
    it 'should return a Bookmark instance of the record saved' do
      bookmark = Bookmark.create 'Create Test', 'https://creation.com'

      expect(Bookmark.all).to include bookmark
    end

    it 'should throw an exception if url is already saved' do
      pending
      Bookmark.create 'First Bookmark', 'https://this_url.com'
      expect { Bookmark.create 'Second Bookmark', 'https://this_url.com' }
        .to raise_error DuplicateBookmarkError, "This url is already saved"
    end

    it 'should throw an exception if title already exists' do
      pending
      Bookmark.create 'First Bookmark', 'https://this_url.com'
      expect { Bookmark.create 'First Bookmark', 'https://that_url.com' }
        .to raise_error DuplicateBookmarkError, "This title is already in use"
    end
  end

  describe ".delete" do
    it "should remove the bookmark from the database" do
      bookmark = Bookmark.create "Test 1", "https://test_1.com"
      Bookmark.create "Test 2", "https://test_2.com"

      Bookmark.delete(bookmark.id)
      
      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 1
      expect(bookmarks).not_to include bookmark
    end
  end
end
