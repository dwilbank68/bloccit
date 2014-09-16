module ApplicationHelper

  def errors?(errors)
    puts "errors is #{errors.inspect}"
    if errors.any?
      'form-group has-error'
    else
      'form-group'
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end

end
