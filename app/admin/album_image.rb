#encoding: utf-8
ActiveAdmin.register AlbumImage do
  menu false


  member_action :move_up, :method => :get
  member_action :move_down, :method => :get

  controller do

    def destroy
      @section = AlbumImage.find(params[:id])
      @section.destroy
      redirect_to request.referer
      flash[:notice] = "Ieraksts veiksmīgi izdzēsts!"
    end

    def move_up
      AlbumImage.find(params[:id]).move_up
      redirect_to request.referer
    end

    def move_down
      AlbumImage.find(params[:id]).move_down
      redirect_to request.referer
    end
    
  end  

end
