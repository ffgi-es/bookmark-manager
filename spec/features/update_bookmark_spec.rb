feature "update bookmark" do
  scenario "should identify bookmark by id and update the relavent bookmark" do
    bookmark = Bookmark.create 'Goggle', 'http://goggle.com'

    visit '/bookmarks'

    within('#' + bookmark.id.to_s) { click_button 'Update' }

    fill_in 'url', with: 'http://google.com'
    fill_in 'title', with: 'Google'

    click_button 'Update'

    expect(page).to have_link 'Google', href: 'http://google.com'
    expect(page).not_to have_link 'Goggle', href: 'http://goggle.com'
  end
end
