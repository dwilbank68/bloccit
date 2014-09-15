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
    puts "errors is #{errors.inspect}"
    if errors.any?
      'form-group has-error'
    else
      'form-group'
    end

  end

end

