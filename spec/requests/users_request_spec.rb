require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get users_path
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text' do
      get users_path
      expect(response.body).to include('<h1 class="heading">Rails Blog</h1>')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create(name: 'Talha', photo: 'https://avatars.githubusercontent.com/u/114238556?v=4',
                         bio: 'Learning More.')
      get user_path(user)
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      user = User.create(name: 'Talha', photo: 'https://avatars.githubusercontent.com/u/114238556?v=4',
                         bio: 'Learning More.')
      get user_path(user)
      expect(response).to render_template('show')
    end

    it 'includes correct placeholder text' do
      User.create(name: 'Talha', photo: 'https://avatars.githubusercontent.com/u/114238556?v=4', bio: 'Learning More.')
      get users_path
      expect(response.body).to include('<h1 class="heading">Rails Blog</h1>')
    end
  end
end
