module ApplicationHelper
  def devise_error_message!
    return '' if resource.errors.empty?

    messages = ''
    resource.errors.full_messages.uniq.each do |message|
      messages += '<li class="list-group-item">' + message + '</li>'
    end

    html = <<-HTML
    <div class="row">
      <div class="col-md-12">
        <div class="panel panel-danger">
          <div class="panel-heading">Errores al cambiar contrase&ntilde;a</div>
          <ul class="list-group">
            #{messages}
          </ul>
        </div>
      </div>
    </div>
    HTML

    html.html_safe
  end
end
