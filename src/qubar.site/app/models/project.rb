class Project < ActiveRecord::Base
  store :notes
  attr_accessible :description, :name, :urn, :notes, :sites, :sites_attributes
  has_many :photos, :as => :imageable
  has_many :project_sites
  has_many :sites, :through => :project_sites
  accepts_nested_attributes_for :sites
  
  validates :name, :presence => true
end
