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
        if !logged_in?
            redirect '/login'
        else
            @entity = Entity.new(params[:entity])
            if !@entity.save
                flash[:message]="Error saving entity. Please check entries."
                redirect '/entities/new'
            else
                @entity.user = current_user
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
            @loans = Loan.all
            @entity = Entity.find(params[:id])
            if @entity.user == current_user
                erb :'/entities/edit'
            else
                flash[:message] = "Not your data to edit"
                redirect "/entities/#{@entity.id}"
            end
        else
            redirect '/login'
        end
    end

    patch '/entities/:id' do
        if logged_in?
            @entity = Entity.find(params[:id])
            if @entity.user == current_user
                @entity.update(params[:entity])
                @entity.save
            else
                flash[:message] = "Not your data to edit"
            end
            redirect "/entities/#{@entity.id}"
        else
            redirect "/login"
        end
    end

    delete '/entities/:id/delete' do
        if logged_in?
            @entity = Entity.find(params[:id])
            if @entity.user == current_user
                @entity.delete
                redirect '/entities'
            else
                flash[:message] = "Not your data to edit"
                redirect "/entities/#{@entity.id}"
            end
        else
            redirect '/login'
        end
    end
end
