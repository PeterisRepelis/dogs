#encoding: utf-8
class MemberUploadsController < ApplicationController

    def create
      if params[:member_upload].present?
        # raise  params.inspect
        MemberUpload.create(permit_params)
        flash[:notice] = 'Paldies, attēls pievienots!'
        redirect_to request.referer 
      end   
    end 
    
    private

    def permit_params
      params.require(:member_upload).permit(:is_visible, :image, :dog_name,
        :member_name, :member_phone, :member_email,
        :image_file_name, :id, :image_content_type, :image_file_size, :image_updated_at)
    end

end
