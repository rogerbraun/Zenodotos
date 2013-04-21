# -*- encoding : utf-8 -*-
module BooksHelper
  def link_action name, icon, path, book, options = {}
    options.merge!({
      data: {
        title: I18n.t("admin.books.actions.#{name}.title"),
        content: I18n.t("admin.books.actions.#{name}.content"),
        trigger: 'hover'
      },
      class: 'btn btn-small',
      id: "#{name}_book_#{book.id}"
    })

    link_to icon(icon),
      path,
      options

  end
end
