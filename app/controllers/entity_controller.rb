class EntityController < ApplicationController

    get '/entities' do
        @route = Rack::Request.new(env).path_info
        if logged_in?
            @entities = Entity.all
            erb :'/entities/index'
        else
            redirect '/login'
        end
    end

    get '/entities/new' do
        @route = Rack::Request.new(env).path_info
        if logged_in?
            @loans = Loan.all
            erb :'/entities/new'
        else
            redirect '/login'
        end
    end

    post '/entities' do
        if !logged_in
            redirect '/login'
        else
            @user = current_user
            @entity = Entity.new(params[:entity])
            if !@entity.save
                flash[:message]="Error saving entity. Please check entries."
                erb :'/entities/new'
            else
                @entity.save
                redirect '/entities'
            end
        end
    end

    get '/entities/:id' do
        @route = Rack::Request.new(env).path_info
        if logged_in?
            @entity = Entity.find(params[:id])
            erb :'/entities/show'
        else
            redirect '/login'
        end
    end

    get '/entities/:id/edit' do
        @route = Rack::Request.new(env).path_info
        if logged_in?
            @user = current_user
            @entity = Entity.find(params[:id])
            #update entity.last_user once column added
            erb :'/entities/edit'
        else
            redirect '/login'
        end
    end

    patch '/entities/:id' do
        if logged_in?
            @entity = Entity.find(params[:id])
            @entity.update(params[:entity])
            @entity.save
            redirect "/entities/#{@entity.id}"
        else
            redirect "/login"
        end
    end

    delete '/entities/:id/delete' do
        if logged_in?
            @entity = Entity.find(params[:id])
            @entity.delete
            redirect '/entities'
        else
            redirect '/login'
        end
    end
end
