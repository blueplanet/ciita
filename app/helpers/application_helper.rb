module ApplicationHelper
  def markdown(text)
    options = { hard_wrap: true, autolink: true, fenced_code_blocks: true }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render text
  end
end
