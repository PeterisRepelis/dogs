#encoding: utf-8
ActiveAdmin.register Page do
  menu :label => "Sadaļas"

   sortable tree: true,
           sorting_attribute: :position,
           parent_method: :parent,
           children_method: :children,
           roots_method: :roots

    permit_params :resource_type, :resource_id, :root_page, :use_html_page, :layout_type,
                  :html_page, :popup, :show_at_menu, :ancestry, :page_height, :background_type,
                  :bacground_color, :image, :products_attributes, :content, :slug, :show_title,
                  :title, :visible, :position, :page_link, :parent_id, :root_page,
                  :blank_page, :friendly_id, :slug, :image, :title, :content,:friendly_id, :slug,
                  page_albums_attributes: [:id, :album_id, :page_id, :_destroy]  
  
    index  :title => proc{"Sadaļas"}, :as => :sortable do
        label do |c| 
          "#{c.title} (#{c.slug})   #{c.visible ? "[redzama]" : "[neredzama]"}" rescue c.title
        end # item content

         actions defaults: false do |page|

          link_to "Custom action", admin_page_path(page)

          div do |a|
            arr = []
            arr << link_to("Apskatīt", admin_page_path(page))
            arr << link_to("Labot", edit_admin_page_path(page))
            arr << link_to("Dzēst", admin_page_path(page), :confirm => I18n.t("destroy_question"), :method => :delete)
            arr.join(" ").html_safe
          end  
         end     
      end        

    show :title => proc{"Sadaļas"} do
      attributes_table do
        row "ID:" do |c| c.id end
        row "Friendly ID:" do |c| c.slug end
        row "Sadaļas URL saite" do |c| c.page_link end
        row "Title" do |c| c.title end
      end
            

    end


  form do |f|
    f.inputs "Lapa" do
      f.input :visible, :label => "Redzama", :hint => ""
      f.input :show_title, :label => "Rādīt sadaļas nosaukumu", :hint => ""
      f.input :use_html_page, :as => :hidden, :value => :true
      f.input :html_page, :label => "Sadaļas template", :as => :select, :include_blank => false, :collection => Page::HTML_PAGES
      f.input :image, :wrapper_html => {:class => ""}, :label => "Galvenā bilde", :hint => f.object.image.url.present? ? f.template.image_tag(f.object.image.url(:thumb)) : f.template.content_tag(:span, "Vēl nav pievienota bilde") 
      
      if params[:action] == "edit"
          if f.object.resource_type == ""
            option_list = []          
          else  
            option_list = (eval(f.object.resource_type).all rescue []) 
          end  
       end

      f.input :resource_type, :label => "Sadaļas resource type", :as => :select, :include_blank => false, :collection => Page::RESOURCE_TYPES, :input_html => {:class => "resource_type_select"}
      f.input :resource_id, :label => "Sadaļas resource", :as => :select, :collection => option_list, :selected => f.object.resource_id, :input_html => {:class => "resource_type_options"}
      f.input :position, :label => "Postition", :hint => ""
      f.input :page_link, :label => "Links"
      f.input :title, :label => "Title", :input_html => {:class => "slug_input"}
      f.input :slug, :label => "FRIENDLY ID*", :wrapper_html => {:class => "necessarily"}, :input_html => {:class => "slug_output"}
      f.input :content, :label => false, :as => :ckeditor, :input_html => {:class => "ckeditor"}
    end

      f.has_many :page_albums do |ai|
        ai.input :album_id, :label => "Albūms", :as => :select, :collection => Album.all.map{|a| [a.title, a.id]}
      end 

    f.actions do  
      f.action :submit, :as => :input , :label => "Save"
      f.action :cancel, :wrapper_html => { :class => "cancel" }, :label => "Cancel" 
    end
  end

  collection_action :string_to_friendly_url, :method => :get
  collection_action :rerender_resource, :method => :get

  controller do
    def string_to_friendly_url
       respond_to do |format| 
          format.json { 
            render :json => {:data => params[:text].parameterize("-")}
          } 
          format.html { 
            raise "html".inspect
            render :nothing => true, :notice => 'Update SUCCESSFUL!' 
          } 
        end 
    end  

    def index
      @page_title = "Sadaļas"
      super
    end

    def update
      super
    end  


    def rerender_resource
      category = params[:category]
      if category.present?
        options_hash = {}
        if category == ""
            options_hash = {} 
        else  
          @resources = eval(category).all
          @resources.each do |r|
            options_hash["#{r.title}"] = r.id
          end
        end    
        respond_to do |format| 
          format.json { 
            render :json => {:options_hash => options_hash}
          } 
          format.html { 
            raise "html".inspect
            render :nothing => true, :notice => 'Update SUCCESSFUL!' 
          } 
        end 

      end #if category  
    end  


  end  



end