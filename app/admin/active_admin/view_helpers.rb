def input(object, name)
  id = (object.class.to_s + "_" + name.to_s).downcase
  form_name = "#{object.class.to_s.downcase}[#{name.to_s.downcase}]"
  "<span class='labeled_input'
    <label for='#{id}'>#{name.to_s.capitalize}</label>
    <input id='#{id}' name='#{form_name}' value='#{object.send(name)}' />
  </span>
  ".html_safe
end
def textarea(object, name, rows=2)
  id = (object.class.to_s + "_" + name.to_s).downcase
  form_name = "#{object.class.to_s.downcase}[#{name.to_s.downcase}]"
  "<span class='labeled_input'
    <label for='#{id}'>#{name.to_s.capitalize}</label>
    <textarea id='#{id}' name='#{form_name}' rows='#{rows}'>#{object.send(name)}</textarea>
  </span>
  ".html_safe
end
