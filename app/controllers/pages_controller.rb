#encoding: utf-8
class PagesController < ApplicationController
  # layout "#{proc{PAGE[:layout]}}"

  # before_filter :create_missing_slugs
  before_filter :set_current_page
  before_filter :set_top_page
    # before_filter :authenticate


    def authenticate
     ids = Setting.uncached_value_for("pages_with_passwords").split(",")
      if ids.include?(params[:id])
        authenticate_or_request_with_http_basic('Administration') do |username, password|
          username == 'maratoni' && password == 'parole'
        end
      end  
    end

      def show
    if @current_page.page_link.present? 
      redirect_to @current_page.page_link
    else
       render :template => 'pages/show', :layout => "application"
    end   
  end

  def create_missing_slugs
    Page.create_missing_slugs
  end 

  def set_current_page
    if (params[:page_id] || params[:id]).present?
      @current_page = Page.where(slug: (params[:page_id] || params[:id])).last rescue nil
      @current_page = Page.where(:visible =>  true).order("position asc").first if @current_page.blank?
      @selected_top_page = @current_page = nil if (params[:page_id] || params[:id]) == 'my_products'
    end 
  end 

  def set_top_page
    return false unless @current_page 
    @top_pages = Page.where(:ancestry => nil, :visible => true).order("position asc")
    if (@current_page.parent && @current_page.parent.parent && @current_page.parent.parent.parent)
        @selected_top_page = @current_page.parent.parent.parent
      elsif (@current_page.parent && @current_page.parent.parent)
        @selected_top_page = @current_page.parent.parent
      else
        @selected_top_page = @current_page.parent || @current_page
      end
  end 



end



