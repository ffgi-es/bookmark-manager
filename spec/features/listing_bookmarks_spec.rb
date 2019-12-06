RSpec.feature 'interacting with bookmarks' do
  scenario 'there has a title' do
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

  context 'listing bookmarks' do
    before :each do
      Bookmark.create 'Test 1', 'http://www.test_1.com'
      Bookmark.create 'Test 2', 'http://www.test_2.com'
      Bookmark.create 'Test 3', 'http://www.test_3.com'
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

  context 'adding bookmarks' do
    scenario "filling in new bookmark info and saving a bookmark" do
      visit '/bookmarks'

      fill_in 'title', with: 'New Test Bookmark'
      fill_in 'url', with: 'http://www.new_test_1.com'
      click_button 'Save'

      expect(page).to have_content 'New Test Bookmark'
      expect(page).to have_content 'http://www.new_test_1.com'
    end
  end
end
