class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    items_path
  end

  helper_method :markdown

  private

    def markdown(text)
      options = { autolink: true, fenced_code_blocks: true }
      render = Redcarpet::Render::HTML.new hard_wrap: true
      Redcarpet::Markdown.new(render, options).render text
    end
end
