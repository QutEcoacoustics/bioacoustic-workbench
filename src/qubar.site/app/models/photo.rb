class Photo < ActiveRecord::Base
  attr_accessible :copyright, :uri
  
  validates :uri, :presence => true
  validates_format_of :uri, :with => URI::regexp(%w(http https))
  validates :copyright, :presence => true
end
