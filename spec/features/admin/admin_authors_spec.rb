require 'rails_helper'

RSpec.describe 'Admin Authors' do
  before do
    create(:author)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_authors_path
  end

  let(:author_attributes) { attributes_for(:author) }

  it 'Admin can create an Author' do
    click_link('New Author')
    fill_in 'author[first_name]', with: author_attributes[:first_name]
    fill_in 'author[last_name]', with: author_attributes[:last_name]
    click_button('Create Author')

    expect(page).to have_content(author_attributes[:first_name])
    expect(page).to have_content(author_attributes[:last_name])
  end

  it 'Admin can view the Author' do
    click_link('View', match: :first)

    expect(page).to have_current_path(admin_author_path(Author.last))
  end

  it 'Admin can delete the Author' do
    expect { page.accept_confirm { click_link('Delete', match: :first) } }.to change(Author, :count).by(-1)
  end

  it 'Admin can edit the Author' do
    new_first_name = FFaker::Name.first_name
    new_last_name = FFaker::Name.last_name
    click_link('Edit', match: :first)

    expect(page).to have_current_path(edit_admin_author_path(Author.last))

    fill_in 'author[first_name]', with: new_first_name
    fill_in 'author[last_name]', with: new_last_name
    click_button('Update Author')

    expect(page).to have_content(new_first_name)
    expect(page).to have_content(new_last_name)
  end
end
