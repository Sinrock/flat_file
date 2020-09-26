class ArtistController < ApplicationController

    get '/artists' do 
       if   !logged_in?
            redirect to '/login'
       else
            @artists = Artist.all
            erb :'artists/index'       
       end
    end

    get '/artists/new' do 
        if !logged_in?
            redirect '/login' 
        else
            @artists = Artist.all
            erb :'artists/new'
        end
    end

    post '/artists' do 
        @artist = Artist.new(params)
        @artist.save
        erb :'/artists/show'
    end
        
    get '/artists/:id' do
        if !logged_in?
           redirect '/login' 
        else
            @artist = Artist.find_by(id: params[:id])
        end
        if @artist
            erb :'/artists/show'
        else
            redirect '/artists'
        end
    end

    get '/artists/:id/edit' do 
        @artist = Artist.find(params[:id])
        erb :'artists/edit'
    end

    patch '/artists/:id' do
        @artist = Artist.find(params[:id])
        if @artist.update(params[:artist])
            redirect to "/artists/#{@artist.id}"
        else
            erb :"artists/edit"
        end
    end

    delete '/artists/:id' do
        @artist = Artist.delete(params[:id])
        redirect '/artists'
    end
end