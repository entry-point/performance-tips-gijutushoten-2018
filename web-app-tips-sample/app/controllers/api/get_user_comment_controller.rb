class Api::GetUserCommentController < ApplicationController
  def show
    expires_now
    user_comments = User
      .joins(:comments)
      .select('users.*, comments.comment')
      .order(:id)
      .limit(20)

    render json: {
      lists: user_comments
    }
  end
end
