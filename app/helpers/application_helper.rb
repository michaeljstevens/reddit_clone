module ApplicationHelper

  def quick_form(options = {}, &block)
    text = capture(&block)
    html = <<-HTML
      <form action="#{options[:url]}" method="post">
        <input type="hidden" name="_method" value="#{options[:method]}">
        <input type="hidden" name="authenticity_token" value="#{form_authenticity_token}">
    HTML
    html += text
    html += <<-HTML
        <input type="submit" value="Save", class="btn btn-sm btn-success">
      </form>
    HTML
    html.html_safe
  end

end
