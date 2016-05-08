ActiveAdmin.register Member do

  menu :label => "Dalībnieki" 

  permit_params :is_visible, :image, :dog_name, :member_name, :member_phone, :member_email

  index :title => "Dalībnieki"  do
    column "ID", :id
    # column "Attēls" do |c| link_to(image_tag(c.image.url(:thumb)), c.image.url, :target => "_blank") rescue "-" end
    # column "Redzams" do |c| c.is_visible ? 'Jā' : 'Nē' end
    # column "Suņa nosaukums", :dog_name
    column "Vārds", :member_name
    actions
  end

  show do
    attributes_table do
      row "ID" do |c| c.id end 
      # row "Redzams" do |c| c.is_visible ? 'Jā' : 'Nē' end
      # row "Suņa nosaukums", :dog_name
      row "Vārds", :member_name
    end  
  end  

  form do |f|
    f.inputs "Dalībnieks" do
      # f.input :is_visible, :label => "Redzams"
      # f.input :dog_name, :label => "Nosaukums"
      f.input :member_name, :label => "Nosaukums"
      # f.input :image, :as => :file, :label => "Attēls"
    end    

    f.actions do  
      f.action :submit, :as => :input , :label => "Save"
      f.action :cancel, :wrapper_html => { :class => "cancel" }, :label => "Cancel"
    end  
  end


end


    