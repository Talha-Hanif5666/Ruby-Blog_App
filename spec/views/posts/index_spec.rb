require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  let!(:first_user) { User.first }
  let!(:users) { [first_user] }
  let!(:posts) { Post.all }

  first_user = User.create(name: 'Yetemegn Telaye', photo: 'https://avatars.githubusercontent.com/u/75949338?v=4',
                           bio: 'Front-end Developer with a passion for React')

  first_post = Post.create(author_id: first_user.id, title: 'Hello', text: 'ONE This is my first post')
  second_post = Post.create(author_id: first_user.id, title: 'Hi there', text: 'ONE This is my second post')

  first_comment = Comment.create(author_id: first_user.id, post_id: first_post.id,
                                 text: 'Hi, this is my first comment.')

  before do
    visit user_posts_path(first_user.id)
  end

  describe 'content' do
    it "should display user's profile picture" do
      expect(page).to have_css("img[src='#{first_user.photo}']")
    end
    it "should display user's profile name" do
      expect(page).to have_content(first_user.name)
    end
    it 'should display number of posts by the user' do
      expect(page).to have_content("Number of posts: #{first_user.posts.count}")
    end
    it 'should display titles of all posts' do
      expect(page).to have_content(first_post.title)
      expect(page).to have_content(second_post.title)
    end
    it 'should display contents of all posts' do
      expect(page).to have_content(first_post.text)
      expect(page).to have_content(second_post.text)
    end
    it 'should display contents of recent comments' do
      expect(page).to have_content(first_comment.text)
    end
    it 'should display number of comments of all posts' do
      expect(page).to have_content("Comments: #{first_post.comments_counter}")
      expect(page).to have_content("Comments: #{second_post.comments_counter}")
    end
    it 'should display number of likes of all posts' do
      expect(page).to have_content("Likes:#{first_post.likes_counter}")
      expect(page).to have_content("Likes:#{second_post.likes_counter}")
    end
    it 'should have a button for pagination' do
      expect(page).to have_button('Pagination')
    end
    it 'should go to the post details page when a single post is clicked' do
      click_link first_post.title
      expect(page).to have_current_path(user_post_path(first_user.id, first_post.id))
    end
  end
end
