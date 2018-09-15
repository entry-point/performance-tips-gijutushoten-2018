class NPlusOneController < ApplicationController
  def show
    search_start_time = Time.now.to_f

    @users_comments = if n_plus_one?
      user_comments_n_plus_1
    else
      users_comments_of_joins
    end

    search_end_time = Time.now.to_f
    @search_time = (search_end_time - search_start_time) * 1000
  end

  private

  def n_plus_one?
    params[:n_plus_one].present?
  end

  def users_comments_of_joins
    User.joins(:comments)
      .select(:name, :comment)
      .page(current_page)
  end

  def user_comments_n_plus_1
    results = []
    comments = Comment.offset(rand(1..Comment.count))
    comments.each do |c|
      results << OpenStruct.new(
        name: User.find(c.user_id).name,
        comment: c.comment
      )
    end
    Kaminari.paginate_array(results).page(current_page)
  end

  def current_page
    params[:page]
  end
end
