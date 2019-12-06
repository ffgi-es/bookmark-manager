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
  end

  context 'listing bookmarks' do
    before :each do
      Bookmark.create 'Test 1', 'http://www.test_1.com'
      Bookmark.create 'Test 2', 'http://www.test_2.com'
      Bookmark.create 'Test 3', 'http://www.test_3.com'
    end

    scenario 'has links' do
      visit '/bookmarks'

      expect(page).to have_link 'Test 1', href: 'http://www.test_1.com'
      expect(page).to have_link 'Test 2', href: 'http://www.test_2.com'
      expect(page).to have_link 'Test 3', href: 'http://www.test_3.com'
    end
  end

  context 'adding bookmarks' do
    scenario "filling in new bookmark info and saving a bookmark" do
      visit '/bookmarks'

      fill_in 'title', with: 'New Test Bookmark'
      fill_in 'url', with: 'http://www.new_test_1.com'
      click_button 'Save'

      expect(page).to have_link 'New Test Bookmark', href: 'http://www.new_test_1.com'
    end
  end

  context 'deleting bookmarks' do
    scenario "clicking a button next to the link deletes the bookmark" do
      bookmark = Bookmark.create 'Test 1', 'http://www.test_1.com'
      Bookmark.create 'Test 2', 'http://www.test_2.com'

      visit '/bookmarks'

      within('#'+ bookmark.id.to_s) { click_button 'Delete' }

      expect(page).not_to have_link 'Test 1', href: 'http://www.test_1.com'
      expect(page).to have_link 'Test 2', href: 'http://www.test_2.com'
    end
  end
end
