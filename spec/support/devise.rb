include Warden::Test::Helpers

module DeviseFeatureHelper
  def login_with(user = create(:user))
    visit root_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password

    click_on 'ログイン'
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include DeviseFeatureHelper, type: :feature
end
