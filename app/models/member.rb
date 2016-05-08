#encoding: utf-8
class Member < ActiveRecord::Base
  has_attached_file :image, :styles => {:thumb => 'x70', :medium => '225x260#', :big => '500x800>'}, :default_url => "/assets/default_page_image.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage/
end
