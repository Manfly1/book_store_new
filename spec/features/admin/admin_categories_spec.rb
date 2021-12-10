# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Categories' do
  before do
    create(:category)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_categories_path
  end

  let(:category_attributes) { attributes_for(:category) }

  it 'Admin can create a Category' do
    click_link('New Category')

    fill_in 'category[name]', with: category_attributes[:name]
    click_button('Create Category')

    expect(page).to have_content(category_attributes[:name])
  end

  it 'Admin can view the Category' do
    click_link('View', match: :first)

    expect(page).to have_current_path(admin_category_path(Category.last))
  end

  it 'Admin can delete the Category' do
    expect { page.accept_confirm { click_link('Delete', match: :first) } }.to change(Category, :count).by(-1)
  end

  it 'Admin can edit the Category' do
    new_name = FFaker::Book.genre
    click_link('Edit', match: :first)

    fill_in 'category[name]', with: new_name
    click_button('Update Category')

    expect(page).to have_content(new_name)
  end
end
