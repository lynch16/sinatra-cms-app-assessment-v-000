class EntityController < ApplicationController

    get '/entities' do
        if !!session[:id]
            @entities = Entity.all
            erb :'/entities/index'
        else
            redirect '/login'
        end
    end

    get '/entities/new' do
        if !!session[:id]
            @loans = Loan.all
            erb :'/entities/new'
        else
            redirect '/login'
        end
    end

    post '/entities' do
        @user = User.find(session[:id])
        @entity = Entity.new(params[:entity])
        if !@entity.save
            flash[:message]="Error saving entity. Please check entries."
            erb :'/entities/new'
        else
            @entity.save
            redirect '/entities'
        end
    end

    get '/entities/:id' do
        if !!session[:id]
            @entity = Entity.find(params[:id])
            erb :'/entities/show'
        else
            redirect '/login'
        end
    end

    get '/entities/:id/edit' do
        if !!session[:id]
            @user = User.find(session[:id])
            @entity = Entity.find(params[:id])
            #update entity.last_user once column added
            erb :'/entities/edit'
        else
            redirect '/login'
        end
    end

    patch '/entities/:id' do
    end

    delete '/entities/:id/delete' do
    end
end
