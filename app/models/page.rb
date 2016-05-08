#encoding: utf-8
class Page < ActiveRecord::Base
 
  has_attached_file :image, :styles => {:thumb => 'x70', :medium => '225x260#', :big => '500x800>'}, :default_url => "/assets/default_page_image.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage/

  SECTION_LIST ={"Standarta sadaļa" => "", "Ziņas" => "/posts"}
  
  HTML_PAGES = {"Sākumlapa" => 1,
    "Tukša lapa" => 2,
    "Par mums" => 3,
    "Noteikumi" => 4,
    "Ziedojumi" => 5,
    "Dalībnieki" => 6,
    "Kontakti" => 7
  }

  RESOURCE_TYPES = {"Standart page" => "",
    "Album page" => "Album"
  }

  has_ancestry :orphan_strategy => :rootify
  
  validates :slug, :presence => true
  validates_format_of :slug, with: /\A[0-9a-z\-\_]+\z/i
  validates_uniqueness_of :slug, case_sensitive: false

  def self.find_slug(slug)
      Page.where(:slug => slug).last
      # return record
  end

  def self.find_by_friendly_name(input)
      page = Page.where(slug: input).first
      record = page.present? ? page : find(input)
      raise ActiveRecord::RecordNotFound unless record
      return record
  end

  def set_root_page
    self.root_page = false
    self.root_page = true if self.root_page? 
  end

  def root_page?
    self.position == 0
  end 

  def have_submenu?
      return $pages_with_childs.include?(id)
  end

  def sorted_childs
      Page.where(:parent_id => id).order("position asc")
  end


  class << self
    def find_by_url(url, live = true)
      Page.last if ActiveRecord::Base.connection.table_exists? 'pages'
    end
  end
end
