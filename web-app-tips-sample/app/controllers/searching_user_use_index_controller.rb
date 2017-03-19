class SearchingUserUseIndexController < ApplicationController
  def show
    @search_name = params[:name]
    @search_age = params[:age].strip.to_i if (params[:age].try(:strip) =~ /\A[0-9]+\z/).present?

    condition = []
    search_params = {}
    if params[:name].present?
      condition << 'name LIKE :name'
      search_params[:name] = "#{params[:name]}%"
    end

    if @search_age.present?
      condition << 'age >= :age'
      search_params[:age] = @search_age
    end

    if condition.length != 0
      @users = User.where(condition.join(' and '), search_params).order(:name).page params[:page]
    else
      @users = User.order(:name).page params[:page]
    end
  end
end
