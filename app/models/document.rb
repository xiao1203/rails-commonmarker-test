class Document < ApplicationRecord
  before_save :assign_html

  def assign_html
    self.html = CommonMarker.render_html(markdown, :DEFAULT)
  end
end
