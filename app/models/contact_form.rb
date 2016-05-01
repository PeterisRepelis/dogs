#encoding: utf-8
class ContactForm < ActiveRecord::Base
  validates :name, :presence => true
  STATES = {"jauns" => 1, "procesā" => 2, "noslēgts" => 3}

  after_create :send_notification

  def send_notification
    # Emailer.notification(self).deliver if Setting.uncached_value_for('send_emails') == '1'
  end  
  
end 

