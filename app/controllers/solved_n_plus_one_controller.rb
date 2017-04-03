class SolvedNPlusOneController < ApplicationController
  def show
    @users_comments = User.joins(:comments)
                 .select(:name, :comment)
                 .limit(100)
  end
end
