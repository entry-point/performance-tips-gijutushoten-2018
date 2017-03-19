class UnsolvedNPlusOneController < ApplicationController
  def show
    @users = []
    @comments = Comment.offset(rand(1..Comment.count)).limit(100)
    @comments.each do |comment|
      @users << User.find_by(id: comment.user_id)
    end
  end
end
