require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let!(:user) { create :user }
  let!(:items) { create_list :item, 5 }
  before { sign_in user }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: items.first.tags.first.name
      expect(response).to have_http_status(:success)
    end
  end
end
