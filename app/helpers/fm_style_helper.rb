module FmStyleHelper
  def fm_textinput(name, options = {})
    label = options[:label] || name.capitalize
    spans = options[:spans] || 5
    "<div class='span2'><div class='label'>#{label}</div></div>
    <div class='span#{spans - 2}'>
      <input id='#{name}' name='#{name}' value='#{@book.send(name.to_sym)}' class='span#{spans - 2}' />
    </div>".html_safe
  end
end
