# ユーザをテーブルから検索する。
# Indexが有効か、そうでないかの差を確認できるようにするためのもの
class SearchUserOfIndexController < ApplicationController
  after_action :assign_params

  # 15回検索を行う  
  def show
    @elapsed_time_of_sum = 0
    @elapsed_time_of_one_hundlred = []
    @row_count = 20
    start_time = Time.now
    100.times do
      @users = if use_index?
                 search_users_use_index(*generate_conditions)
               else
                 search_users_no_use_index(*generate_conditions)
               end
      elapsed_time = (Time.now - start_time).round(7)
      @elapsed_time_of_sum += elapsed_time
      @elapsed_time_of_one_hundlred << elapsed_time
    end
    @use_index = use_index?
  end

  def age
    params[:age].strip.to_i if params[:age].try(:strip) =~ /\A[0-9]+\z/.present?
  end

  def name
    params[:name]
  end

  def use_index?
    params[:use_index].present?
  end

  def current_page
    params[:page]
  end

  def assign_params
    @search_age = age
    @search_name = name
  end

  def generate_conditions
    condition = []
    search_params = {}

    if name.present?
      condition << 'name LIKE :name'
      search_params[:name] = "%#{params[:name]}%"
    end

    if age.present?
      condition << 'age >= :age'
      search_params[:age] = age
    end

    [condition, search_params]
  end

  def search_users_use_index(condition, search_params)
    if condition.length.zero?
      User.where(condition.join(' and '), search_params)
        .order(:name)
        .page(current_page)
    else
      User.order(:name).page(current_page)
    end
  end

  # IGNORE ALL INDEX is 'use index()'
  # source: index hints
  # https://dev.mysql.com/doc/refman/8.0/en/index-hints.html
  def search_users_no_use_index(condition, search_params)
    if condition.length.zero?
      User.from('users use index()')
        .order(:name)
        .order(id: :desc)
        .page(current_page)
    else
      User.from('users use index()')
        .where(condition.join(' and '), search_params)
        .order(:name)
        .order(id: :desc)
        .page(current_page)
    end
  end
end
