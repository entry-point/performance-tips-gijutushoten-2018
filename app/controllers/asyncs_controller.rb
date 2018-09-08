class AsyncsController < ApplicationController
  def show
    @enque_records = Enque.order(id: :desc).page(current_page)
    @notice = flash[:notice]
  end

  def create
    enque = Enque.create!(status: '作成中')
    CreateEnqueJob.perform_later(enque.id)
    flash[:notice] = 'キューに追加しました。'

    redirect_to action: :show
  end

  private

  def current_page
    params[:page]
  end
end
