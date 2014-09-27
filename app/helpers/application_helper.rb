module ApplicationHelper


  # def form_group_tag(errors,&block)
  #   puts &block
  #   if errors.any?
  #     content_tag :div, capture(&block), class: 'form-group has-error'
  #   else
  #     content_tag :div, capture(&block), class: 'form-group'
  #   end
  # end


  def errors?(errors)
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
  # This is here in case some says I can't use 'send'
  
  # def vote_link_classes(post, dir)
  #   if dir == 'up'
  #
  #     if current_user.voted(post) && current_user.voted(post).up_vote?
  #       return "glyphicon glyphicon-chevron-up voted"
  #     else
  #       return "glyphicon glyphicon-chevron-up"
  #     end
  #
  #   elsif dir == 'down'
  #
  #     if current_user.voted(post)&& current_user.voted(post).down_vote?
  #       return "glyphicon glyphicon-chevron-down voted"
  #     else
  #       return "glyphicon glyphicon-chevron-down"
  #     end
  #
  #   else
  #     return "see if /views/votes/_voter.html.erb gave you something other than 'up' or 'down'"
  #   end
  #
  # end

  def vote_link_classes(post,dir)
    if current_user.voted(post) && current_user.voted(post).send("#{dir}_vote?")
      "glyphicon glyphicon-chevron-#{dir} voted"
    else
      "glyphicon glyphicon-chevron-#{dir}"
    end
  end

end

