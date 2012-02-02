# -*- encoding : utf-8 -*-
module ApplicationHelper
  def icon name
    "<i class='icon-#{name}'></i>".html_safe
  end
end
