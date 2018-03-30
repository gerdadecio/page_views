class PageViewsController < ApplicationController
  def index
    responses = PageHit.search(params[:urls])
    render json: responses, status: :ok
  end
end
