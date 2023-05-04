require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Model' do
    before { @user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

    it 'name should not be blank' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'post counter must be greater or equal to 0' do
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end

    describe '#recent_three_posts' do
      let!(:post1) { Post.create(author: @user, title: 'Title1', text: 'Text1', created_at: 2.days.ago) }
      let!(:post2) { Post.create(author: @user, title: 'Title2', text: 'Text2', created_at: 1.day.ago) }
      let!(:post3) { Post.create(author: @user, title: 'Title3', text: 'Text3', created_at: Time.now) }
      let!(:post4) { Post.create(author: @user, title: 'Title4', text: 'Text4', created_at: 3.days.ago) }

      it 'returns the most recent three posts in descending order' do
        expect(@user.recent_three_posts).to eq [post3, post2, post1]
      end

      it 'limits the number of posts returned to three' do
        expect(@user.recent_three_posts.size).to eq 3
      end
    end
  end
end
