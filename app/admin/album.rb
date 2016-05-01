#encoding: utf-8
ActiveAdmin.register Album do
  menu  :label => "Albūmi" 

  filter :title, :label => "Title"
  before_filter :set_admin_locale

    permit_params  :position, :visible, :cover_image, :title,
                            album_images_attributes: [:album_id, :image, :title, :main_image, :position]



  form do |f|
    f.inputs "Albums" do
      f.input :visible, :label => "Redzams"
      f.input :album_category_id, :label => "Kategorija", :as => :select, :collection => AlbumCategory.all.map{|a| [a.title, a.id]}, :include_blank => false
      f.input :cover_image, :as => :file, :label => "Cover", :hint => f.object.cover_image.url.present? ? f.template.image_tag(f.object.cover_image.url(:medium)) : f.template.content_tag(:span, "Picture vēl nav pievienots")    
      f.input :title, :label => "Title"
   if params[:action] == "new"
     f.input :multi_images, :as => :file, :label => "Augšuplādēt vairākus attēlos reizē (max 100)", :input_html => {:multiple => true}
   end  

  end
  
    f.has_many :album_images do |ai|
      ai.input :title, :label => "Title"
      ai.input :image, :wrapper_html => {:class => "page_icon_image"}, :label => "Picture", :hint => ai.object.image.url.present? ? ai.template.image_tag(ai.object.image.url(:thumb)) : ai.template.content_tag(:span, "No image") 
    end 

    f.actions do  
      f.action :submit, :as => :input , :label => "Save"
      f.action :cancel, :wrapper_html => { :class => "cancel" }, :label => "Cancel"
    end  
  end



  index :title => "Albums" do
    
    column "Short code" do |p| "[gallery_id:#{p.id}]" end
    column "Category" do |p| p.album_category.title rescue "-" end
    column "Visible" do |p| p.visible ? "Jā" : "Nē" end
    column "Title" do |p| "#{p.title} (#{p.album_images.count})" end
    column "Cover" do |c| link_to(image_tag(c.cover.url(:thumb)), c.cover.url, :target => "_blank") rescue "-" end
    # column "Skaits vienā lapā (paginātoram)" do |p| p.count_per_page end
    column "Albūma preview attēlu skaits" do |p| p.preview_count end
    column "URL link" do |p| p.url_link end  
    column "Created" do |p| p.created_at end
    column "Actions" do |p|
      arr = []
      arr << link_to("View", admin_album_path(p))
      arr << link_to("Edit", edit_admin_album_path(p))
      arr << link_to("Delete", admin_album_path(p), :confirm => "Are you sure?", :method => :delete)
      arr.join(" ").html_safe
    end 
  end   


    show :title => "Albūms" do
      attributes_table do
        row "Short code:" do |c| "[gallery_id:#{c.id}]" end
        row "Pievienot bildes" do |c|  
          div do 
            render :partial => "admin/albums/inline_form", :locals => {:album => c}
          end
        end   
        row "#{"Visible"}:"  do |p| p.visible ? "Jā" : "Nē" end
        row "#{"Title"}:" do |c| c.title end 
        row "Mainīt nosaukumu" do |c|  
          div do 
            render :partial => "admin/albums/inline_form_title", :locals => {:album => c}
          end
        end   
        row "#{"Skaits vienā lapā (paginātoram)"}:" do |c| c.count_per_page end 
        row "#{"Albūma preview attēlu skaits"}:" do |c| c.preview_count end 
        row "#{"URL link"}:" do |c| c.url_link end 
        row "#{"Cover"}:" do |c| 
          image_tag(c.cover.url(:medium)) rescue "-" 
        end
        row "#{"Created"}:" do |c| c.created_at end
        row "#{"Updated"}:" do |c| c.updated_at end
      end
    panel("Albūma attēli") do 
      table_for(album.album_images.order("position asc").limit(50)) do
        column "Postition" do |c| 
         render :partial => "common/controls", :locals => { :subject => c, :group => @group = album}
        end 
        column "Title" do |p| p.title end
        column "Picture" do |c| link_to(image_tag(c.image.url(:thumb)), c.image.url, :target => "_blank") rescue "-" end
        column "Actions" do |p| 
          div do |a|
            arr = []
            arr << link_to("Delete", admin_album_image_path(p), :confirm => I18n.t("destroy_question"), :method => :delete)
            arr.join(" ").html_safe
          end 
        end    
      end 
   end

  end 




  controller do

    def set_admin_locale
      I18n.locale = "lv" if params[:controller].to_s.include?("admin")
    end

    def create
      # raise params.inspect
      album_images_attributes = params[:album][:multi_images] 
      params[:album][:multi_images] = []
      @album = Album.new(album_params)
      respond_to do |format|
        if @album.save
          if album_images_attributes
            #===== The magic is here ;)
            album_images_attributes.each { |image|
              # raise image.inspect
              # image[1][:image].each do |real|
                 @album.album_images.create(image: image) 
              # end  
            }
          end

          format.html { redirect_to admin_album_path(@album.id), notice: 'album was successfully created.' }
          format.json { render json: @album, status: :created, location: @album }
        else
          format.html { render action: "new" }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end
    end


    def update
      params[:id] = params[:album][:id] if params[:album][:id].present?
      album_images_attributes = params[:album][:multi_images] 
      params[:album][:multi_images] = []
      @album = Album.find(params[:id])
      @album.update_attributes(params[:album])
      if @album.errors.any?
          flash[:alert] = "#{@album.errors.map{|a,b| I18n.t("alerts.#{a.to_s}")+" #{b}"}.join(', ')}" 
          redirect_to request.referer
      else   
        if album_images_attributes
         album_images_attributes.each { |image|
               @album.album_images.create(image: image) 
          }
        end
        flash[:notice] = "Saved!"
        redirect_to admin_album_path(@album)
      end


    end

     private

    def album_params
      params.require(:album).permit(:position, :visible, :cover_image, :title,
                            album_images_attributes: [:album_id, :image, :title, :main_image, :position])
    end



 end


end

