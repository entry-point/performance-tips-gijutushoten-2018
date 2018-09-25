class Api::NPlusOneController < ApplicationController
  def show
    @sql_call_count = 0
    users_comments = if n_plus_one?
                       user_comments_n_plus_1
                     else
                       users_comments_of_joins
                     end

    render json: {
      users_comments: users_comments, 
      sql_call_count: @sql_call_count
    }
  end

  private

  def n_plus_one?
    params[:enable_n_plus_one].to_s == '1'
  end

  def users_comments_of_joins
    @sql_call_count += 1
    User.joins(:comments)
      .select(:id, :name, :comment)
      .order(id: :desc)
      .page(current_page)
  end

  def user_comments_n_plus_1
    results = []
    comments = Comment.offset(1) # rand(1..Comment.count))
    @sql_call_count += 1
    comments.each do |c|
      user = User.find(c.user_id)
      @sql_call_count += 1
      results << OpenStruct.new(
        id: user.id,
        name: user.name,
        comment: c.comment
      )
    end
    results.map!{ |r| r.marshal_dump }
    Kaminari.paginate_array(results).page(current_page)
  end

  def current_page
    params[:page]
  end
end