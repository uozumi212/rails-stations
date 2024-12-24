require 'rails_helper'

RSpec.describe "Admin::Schedules", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/schedules/index"
      expect(response).to have_http_status(:success)
    end
  end

end
