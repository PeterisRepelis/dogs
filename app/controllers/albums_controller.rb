#encoding: utf-8
class AlbumsController < ApplicationController
  before_filter :set_top_page

  def set_top_page
    @top_pages = Page.where(:ancestry => nil, :visible => true).order("position asc")
    @current_page = Page.where(:visible => true).where(:ancestry => nil).where(:page_link => '/galerijas').last
    @selected_top_page = (@current_page.parent.present? ? @current_page.parent : @current_page) rescue nil
  end 

  def index
    @albums = Album.order("created_at desc").page(params[:page]).per(5)
    @page_title = 'Galerijas'
    render "albums/index", :layout => "application"
  end 

  def show
    @album = Album.find(params[:id])
    @page_title = @album.title || 'Galerija'
    @album_images = @album.album_images.page(params[:page]).per(20)
  end 

end




