# -*- encoding : utf-8 -*-
module BorrowersHelper
  def link_action name, icon, path, borrower, options = {}
    options.merge!({
      data: {
        title: I18n.t("admin.borrowers.actions.#{name}.title"),
        content: I18n.t("admin.borrowers.actions.#{name}.content"),
        trigger: 'hover'
      },
      class: 'btn',
      id: "#{name}_borrower_#{borrower.id}"
    })

    link_to icon(icon),
      path,
      options

  end
end
