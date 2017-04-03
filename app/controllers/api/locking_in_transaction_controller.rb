class Api::LockingInTransactionController < ApplicationController
  def show
    ActiveRecord::Base.transaction do
      user_comments = User
        .joins(:comments)
        .select('users.*, comments.comment')
        .order(:id)
        .limit(20)
      user_comments.lock!

      user_comment = user_comments.sample
      user_comment.comment = Faker::Twitter.user[:status][:text]
      sleep sleep_seconds
      user_comment.save!
    end

    render json: { status: 'ok' }
  end

  def sleep_seconds
    params[:sleep_seconds].to_i
  end

  def user_id
    params[:id].to_i
  end
end
