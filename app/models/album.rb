#encoding: utf-8
class Album < ActiveRecord::Base

  attr_accessor :multi_images
  
  has_attached_file :cover_image, :styles => {:thumb => 'x70', :medium => '310x160#'}, :default_url => "/assets/default_page_image.jpg"
  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :cover_image, :content_type => /\Aimage/

  belongs_to :album_category

  has_many :album_images, :dependent => :destroy
  accepts_nested_attributes_for :album_images,:allow_destroy => true

  def cover
    obj = nil
    if self.cover_image.present?
      obj = self.cover_image  
    else  
      if self.main_image.present?
        obj = album_images.where(:id => self.main_image).last.image
      else  
        obj = album_images.order("position asc").first.image
      end 
    end 
  end 

  
end




