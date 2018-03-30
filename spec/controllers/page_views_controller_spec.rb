require 'rails_helper'

describe PageViewsController do

  describe "GET #index" do
    before do
      allow(PageHit).to receive(:search) { {took: 3} }
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
