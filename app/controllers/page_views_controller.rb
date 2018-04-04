class PageViewsController < ApplicationController
  def index
    responses = PageHit.search(
      params[:urls],
      {
        before: params[:before],
        after: params[:after],
        interval: params[:interval]
      }
    )

    render json: responses, status: :ok
  end
end
