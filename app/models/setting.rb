#encoding: utf-8
class Setting < ActiveRecord::Base

  validates_presence_of :name
  
  @@cache = Hash.new
  
  def to_s
    self.description.nil? ? self.name : self.description
  end
  
  def Setting.value_for(name,cashing={})
    return Setting.where(:name => name).last.value if cashing == "no_cashing"
    return @@cache[name] unless @@cache[name].nil?
    setting = Setting.where(name: name).first #find(:first, :conditions => ['name = ?', name])
    @@cache[name] = setting.nil? ? nil : setting.value
    @@cache[name]
  end

  def Setting.uncached_value_for(name) 
    setting = Setting.where(name: name).first #.find(:first, :conditions => ['name = ?', name])
    setting.nil? ? nil : setting.value
  end

  def Setting.all_settings
    [
      ["send_emails", "Ļaut no sistēmas izsūtīt e-apstus (1 - jā, 0 - nē)", "0"],
      ["company_name", "Uzņemuma nosaukums", "Bīglu saostīšanās"],
      ["vat_nr", "PVN numurs", "LV-000000000"],
      ["copyright", "Autortiesības", "© 2016 Bīglu saostīšanās"],
      ["phone_number", "Tālruņa numurs", "+371 20000000"],
      ["mobile_phone_number", "Mobilais tālruņa numurs", "+371 20000000"],
      ["fax", "Faksss", "+371 20000000"],
      ["email", "kājenē attēlotais E-pasts", "info@gmail.com"],
      ["reg_nr", "Reģistrācijas numurs", "Reg-0000000000"],
      ["reg_office", "Juridiskā adrese", "Juridiskā adrese"],
      ["admin_mail", "Epasts uz kuru tiek sūtīti ziņojumi", "info@gmail.com"],
      ["header_content", "Header zonas informācija", "Kontakttālrunis +371 2000000"],
      ["default_meta_keywords", "Noklusējuma meta (SEO) keywords", "Bīglu saostīšanās"],
      ["default_meta_keywords", "Noklusējuma meta (SEO) name", "Bīglu saostīšanās"],
      ["default_meta_description", "Noklusējuma meta (SEO) description", "Bīglu saostīšanās"]
    ]
  end
  
  def Setting.init
    Setting.all_settings.each do |s|
      Setting.create(:name => s[0], :value => s[2], :description => s[1]) unless Setting.where(:name => s[0]).count > 0
    end
  end
end
