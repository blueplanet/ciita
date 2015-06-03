class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    items_path
  end

  helper_method :markdown

  private

    def markdown(text)
      options = { hard_wrap: true, autolink: true, fenced_code_blocks: true }
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render text
    end
end
