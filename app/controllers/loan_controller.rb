class LoanController < ApplicationController

    get '/loans' do
        @route = Rack::Request.new(env).path_info
        if logged_in?
            @loans = Loan.all
            erb :'/loans/index'
        else
            redirect '/login'
        end
    end

    get '/loans/new' do
        @route = Rack::Request.new(env).path_info
        if logged_in?
            erb :'/loans/new'
        else
            redirect '/login'
        end
    end

    post '/loans' do
        if !logged_in?
            redirect '/login'
        else
            @loan = Loan.new(params[:loan])
            params[:entity_ids].each do |id|
                @loan.entities << Entity.all.select { |e| e.id.to_s == id }
            end
            if !@loan.save
                flash[:message]="Error saving loan. Please check entries."
                erb :'/loans/new'
            else
                @loan.user = current_user
                @loan.save
                redirect '/loans'
            end
        end
    end

    get '/loans/:id' do
        @route = Rack::Request.new(env).path_info
        if logged_in?
            @loan = Loan.find(params[:id])
            erb :'/loans/show'
        else
            redirect '/login'
        end
    end

    get '/loans/:id/edit' do
        @route = Rack::Request.new(env).path_info
        if logged_in?
            @loan = Loan.find(params[:id])
            if @loan.user == current_user
                erb :'/loans/edit'
            else
                flash[:message] = "Not your loan to edit"
                redirect "/loans/#{@loan.id}"
            end
        else
            redirect '/login'
        end
    end

    patch '/loans/:id' do
        if logged_in?
            @loan = Loan.find(params[:id])
            @loan.update(params[:loan])
            @loan.save
            redirect "/loans/#{@loan.id}"
        else
            redirect '/login'
        end
    end

    delete '/loans/:id/delete' do
        if logged_in?
            @loan = Loan.find(params[:id])
            if @loan.user == current_user
                @loan.delete
                redirect '/loans'
            else
                flash[:message] = "Not your loan to delete"
                redirect "/loans#{@loan.id}"
            end
        else
            redirect "/login"
        end
    end
end
