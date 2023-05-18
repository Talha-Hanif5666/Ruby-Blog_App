class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    can :destroy, Post, user_id: user.id # User can delete their own posts
    can :destroy, Post if user.role == "admin" # Admin user can delete any post
    can :destroy, Comment, user_id: user.id
    can :destroy, Comment if user.role == "admin"
  end
end
