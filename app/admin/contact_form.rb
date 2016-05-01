#encoding: utf-8
ActiveAdmin.register ContactForm do

  menu :label => "Pieteikumi" 

  index :title => "Iesūtītie jautājumi"  do
    column "ID", :id
    column "Statuss" do |c|
      div :class => "contact_form_state-#{c.state}" do
        ContactForm::STATES.key(c.state)
      end 
    end
    column "Vārds", :name
    column "E-pasts", :email
    column "Tālrunis", :phone
    column "Adrese", :address
    column "Vēlas kļūt par biedru" do |c| c.is_member ? 'Jā' : 'Nē' end
    column "Ziņa", :comment
    column "IP adrese", :ip_address
    actions
  end

  show do
    attributes_table do
      row "ID" do |c| c.id end 
      row "Statuss" do |c| 
        div :class => "contact_form_state-#{c.state}" do
        ContactForm::STATES.key(c.state)
      end 
      end   
      row "Vārds", :name
      row "E-pasts", :email
      row "Tālrunis", :phone
      row "Adrese", :address 
      row "Vēlas kļūt par biedru" do |c| c.is_member ? 'Jā' : 'Nē' end     
      row "IP adrese", :ip_address
      row "Ziņa", :comment
    end  
  end  

end
