require 'taza/page'

module Dashboard
  class ShoesPage < Taza::Page
    element(:shoes) { browser.ul(id: 'shoe_list') }

    element(:specific_shoe) { |the_shoe| browser.li(id: the_shoe) }

    def shoe_list
      shoes.lis.collect { |li| li.id }
    end

    def check_shoe_description(the_shoe)
      specific_shoe(the_shoe).td(class: 'shoe_description')
    end

    def check_shoe_image(the_shoe)
      specific_shoe(the_shoe).img
    end

    def check_shoe_price(the_shoe)
      specific_shoe(the_shoe).td(class: 'shoe_price')
    end
  end
end