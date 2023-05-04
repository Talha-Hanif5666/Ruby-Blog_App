require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post Model' do
    before do
      @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher')
      @post = Post.new(author: @user, title: 'Hello', text: 'This is my first post')
    end

    it 'title should not be blank' do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'should not allow titles longer than 250 characters' do
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
      expect(@post.errors[:title]).to include("is too long (maximum is 250 characters)")
    end

    it 'comment counter must be integer' do
      @post.comments_counter = 1.5
      expect(@post).to_not be_valid
    end

    it 'comment counter must be greater or equal to 0' do
      @post.comments_counter = -1
      expect(@post).to_not be_valid
    end

    it 'like counter must be integer' do
      @post.likes_counter = 1.5
      expect(@post).to_not be_valid
    end

    it 'like counter must be greater or equal to 0' do
      @post.likes_counter = -1
      expect(@post).to_not be_valid
    end

    describe '#update_posts_count' do
      it 'increments the author posts counter by 1' do
        expect { @post.save }.to change { @user.reload.posts_counter }.by(1)
      end
    end

    describe '#recent_five_comments' do
      it 'returns the 5 most recent comments on the post' do
        comment1 = Comment.create(post: @post, author: @user, text: 'This is the first comment')
        comment2 = Comment.create(post: @post, author: @user, text: 'This is the second comment')
        comment3 = Comment.create(post: @post, author: @user, text: 'This is the third comment')
        comment4 = Comment.create(post: @post, author: @user, text: 'This is the fourth comment')
        comment5 = Comment.create(post: @post, author: @user, text: 'This is the fifth comment')
        comment6 = Comment.create(post: @post, author: @user, text: 'This is the sixth comment')
        expect(@post.recent_five_comments).to eq([comment6, comment5, comment4, comment3, comment2])
      end
    end
  end
end
