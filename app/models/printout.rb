# -*- encoding : utf-8 -*-
require "prawn/measurement_extensions"

class Printout < ActiveRecord::Base
  has_many :lendings

  def self.new_from_unprinted
    lendings = Lending.where("printout_id is null").all
    Printout.create(lendings: lendings)
  end
  
  after_create :create_pdf

  def pdf_url
    "/pdf/printout/#{self.id}.pdf"
  end
  
  private

  def folder
    File.join(Rails.root, "public", "pdf", "printout")
  end
  
  def file
    File.join(folder,"#{self.id}.pdf")
  end

  def create_pdf
    system("mkdir -p #{folder}") 
    Prawn::Document.generate(file, page_size: "A4", margin: 0) do |pdf|
      width = pdf.page.document.margin_box.width / 2
      height = pdf.page.document.margin_box.height / 4
      total_width = pdf.page.document.margin_box.width
      total_height = pdf.page.document.margin_box.height

      lendings.sort_by{|l| l.book.signatur}.reverse.each_slice(8) do |slice|
        0.upto(3) do |y|
          0.upto(1) do |x|
            if not slice.empty? 
              lending = slice.pop
              base_x = (x * width) + 5.mm
              base_y = (total_height - (y * height)) - 5.mm
              pdf.bounding_box([base_x, base_y], width: width - 5.mm, height: height -5.mm) do
                 
                pdf.text "Signatur: #{lending.book.signatur} #{lending.book.nebensignatur}"
                pdf.text "\n"
                pdf.text lending.book.titel.to_s
                pdf.text lending.book.autor.to_s
                pdf.text "\n"
                pdf.text "Leihende: #{lending.return_date.strftime("%d.%m.%Y")}"
                pdf.text "Entleiher: #{lending.borrower.name}"

              end
            end
          end
        end
        pdf.start_new_page
      end
    end
  end
end
