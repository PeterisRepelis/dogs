#encoding: utf-8
class ContactFormsController < ApplicationController

    def create
      if params[:contact_form].present?
          params[:contact_form][:ip_address] = request.remote_ip
        ContactForm.create(contact_form_params)
        flash[:notice] = 'Paldies, jūsu pieteikums ir pieņemts!'
        redirect_to request.referer 
      end   
    end 
    
    private

    def contact_form_params
      params.require(:contact_form).permit(:faq_id,:category,:name,
        :email,:phone,:comment,:ip_address,:browser,:state, :address,
        :is_member, :subject, :created_at, :updated_at, :other_recipients)
    end

end
