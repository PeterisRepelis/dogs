#encoding: utf-8
class AlbumImage < ActiveRecord::Base
  # attr_accessible :album_id, :image, :title, :main_image, :position

  has_attached_file :image, :styles => {:thumb => 'x70', :medium => '225x260#', :medium_sq => '306x306#', :big => '500x800>', :large => '900x800>'}, :default_url => "/assets/default_page_image.jpg"
  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :image, :content_type => /\Aimage/

  belongs_to :album

  
   after_create :set_position

    def set_position
      po = AlbumImage.where(:album_id => self.album_id).all.map(&:position).max + 1
      self.update_attribute(:position, po)
    end 

    def show_up_arrow?

      self.position == AlbumImage.where(:album_id => self.album_id).map(&:position).min

    end

    def show_down_arrow?
      self.position == AlbumImage.where(:album_id => self.album_id).map(&:position).max
      
    end

    def move_up
      above_expo = AlbumImage.where(:album_id => self.album_id).where(:position => (self.position || 0) -1)
      above_expo.first.update_attribute("position", self.position)
      self.update_attribute("position", self.position - 1)
    end

    def move_down
      below_expo = AlbumImage.where(:album_id => self.album_id).where(:position => (self.position || 0) +1)
      below_expo.first.update_attribute("position", self.position)
      self.update_attribute("position", self.position + 1)
    end

  
end




