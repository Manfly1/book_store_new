require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #show' do
    let(:book) { create(:book) }

    it 'renders :show template' do
      get :show, params: { id: book.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #index' do
    it 'renders :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'when newest books' do
      get :index, params: { sort_by: 'created_at_DESC' }
      expect(response).to render_template :index
    end

    it 'when ascending title' do
      get :index, params: { sort_by: 'title_ASC' }
      expect(response).to render_template :index
    end

    it 'when descending title' do
      get :index, params: { sort_by: 'title_DESC' }
      expect(response).to render_template :index
    end

    it 'when ascending price' do
      get :index, params: { sort_by: 'price_ASC' }
      expect(response).to render_template :index
    end

    it 'when descending price' do
      get :index, params: { sort_by: 'price_DESC' }
      expect(response).to render_template :index
    end

    it 'when category' do
      create(:category)
      book = create(:book)
      get :index, params: { category: book.categories.first.id }
      expect(response).to render_template :index
    end
  end
end
