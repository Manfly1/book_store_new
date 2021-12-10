# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Books' do
  before do
    create(:book)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_books_path
  end

  let(:book_attributes) { attributes_for(:book).except(:categories, :authors) }

  it 'Admin can create a Book' do
    click_link('New Book')

    fill_in 'book[title]', with: book_attributes[:title]
    fill_in 'book[description]', with: book_attributes[:description]
    fill_in 'book[year]', with: book_attributes[:year]
    fill_in 'book[price]', with: book_attributes[:price]
    fill_in 'book[materials]', with: book_attributes[:materials]
    fill_in 'book[dimensions]', with: book_attributes[:dimensions]
    click_button('Create Book')

    expect(page).to have_content(book_attributes[:title])
  end

  it 'Admin can view the Book' do
    click_link('View', match: :first)

    expect(page).to have_current_path(admin_book_path(Book.last))
  end

  it 'Admin can delete the Book' do
    expect { page.accept_confirm { click_link('Delete', match: :first) } }.to change(Book, :count).by(-1)
  end
end
