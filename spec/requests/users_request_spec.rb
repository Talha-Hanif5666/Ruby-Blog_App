require 'rails_helper'

# we group together our users tests
RSpec.describe '/users', type: :request do
  context 'GET /index' do
    it 'renders a successful response' do
      get users_url
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get users_url
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text' do
      get users_url
      expect(response.body).to include('<h1>Here is a list of all users</h1>')
    end
  end

  context 'GET /show' do
    it 'renders a successful response' do
      get users_url(5)
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get user_url(5)
      expect(response).to render_template('show')
    end

    it 'includes correct placeholder text' do
      get user_url(5)
      expect(response.body).to include('<h1>Here is the user for a given ID</h1>')
    end
  end
end