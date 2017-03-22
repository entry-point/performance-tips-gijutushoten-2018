class AfterLockTableOfCommentsController < ApplicationController
  def show
    @users_comments = User.joins(:comments)
                        .select(:name, :comment, :created_at)
                        .order(:created_at)
                        .reverse_order
                        .page params[:page]

    respond_to do |format|
      format.html
      format.json do
        render json: @users_comments
      end
    end
  end

  def create
    if params[:name].blank? && params[:comment].blank?
      redirect_to action: :show
    end

    ActiveRecord::Base.transaction do
      user = User.create_with(
               email: Faker::Internet.email,
               age:     Faker::Number.between(0, 120),
               sex: ['male', 'female'].sample
             ).find_or_create_by(name: params[:name].strip)
      comment = Comment.new
      comment.comment = params[:comment]
      comment.lock!
      comment.user_id = user.id
      sleep 30
      comment.save!
    end

    redirect_to action: :show
  end
end
