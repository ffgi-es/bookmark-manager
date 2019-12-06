RSpec.feature "Testing Server" do
  scenario "can access homepage" do
    visit '/'
    expect(page).to have_content 'Bookmark Manager'
    expect(page).to have_title 'Bookmark Manager'
  end
end
