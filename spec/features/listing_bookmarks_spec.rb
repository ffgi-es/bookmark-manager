RSpec.feature 'listing bookmarks' do
  scenario 'it has a title' do
    visit '/bookmarks'
    expect(page).to have_content 'Bookmark Manager'
    expect(page).to have_title 'Bookmark Manager'
  end

  scenario 'it has table headings' do
    visit '/bookmarks'
    expect(page).to have_selector 'table'
    expect(page).to have_selector 'th', text: 'Name'
    expect(page).to have_selector 'th', text: 'URL'
  end

  context 'hardcoded contents' do
    before :each do
      begin
        connection = PG.connect dbname: 'bookmark_manager_test'

        connection.exec "INSERT INTO bookmarks (title, url) VALUES ('Test 1', 'http://www.test_1.com')"
        connection.exec "INSERT INTO bookmarks (title, url) VALUES ('Test 2', 'http://www.test_2.com')"
        connection.exec "INSERT INTO bookmarks (title, url) VALUES ('Test 3', 'http://www.test_3.com')"
      ensure
        connection.close if connection
      end
    end

    scenario 'it has default names' do
      visit '/bookmarks'

      expect(page).to have_content 'Test 1'
      expect(page).to have_content 'Test 2'
      expect(page).to have_content 'Test 3'
    end

    scenario 'it has default URLs' do
      visit '/bookmarks'

      expect(page).to have_content 'http://www.test_1.com'
      expect(page).to have_content 'http://www.test_2.com'
      expect(page).to have_content 'http://www.test_3.com'
    end
  end
end
