class LoanController < ApplicationController

    get '/loans' do
        if !!session[:id]
            @loans = Loan.all
            erb :'/loans/index'
        else
            redirect '/login'
        end
    end

    get '/loans/new' do
        if !!session[:id]
            @entities = Entity.new
            erb :'/loans/new'
        else
            redirect '/login'
        end
    end

    post '/loans' do
        @user = User.find(session[:id])
        @loan = Loan.new(params[:loan])
        if !@loan.save
            flash[:message]="Error saving loan. Please check entries."
            erb :'/loans/new'
        else
            @loan.user = @user
            @loan.save
            redirect '/loans'
        end
    end

    get '/loans/:id' do
        if !!session[:id]
            @loan = Loan.find(params[:id])
            erb :'/loans/show'
        else
            redirect '/login'
        end
    end

    get '/loans/:id/edit' do
        if !!session[:id]
            @loan = Loan.find(params[:id])
            @user = User.find(session[:id])
            @entities = Entity.all
            if @user == @loan.user
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
        @loan = Loan.find(params[:id])
        @loan.update(params[:loan])
        @loan.save
        redirect "/loans/#{@loan.id}"
    end

    delete '/loans/:id/delete' do
        @loan = Loan.find(params[:id])
        @user = User.find(session[:id])
        if @loan.user == @user
            @loan.delete
            redirect '/loans'
        else
            flash[:message] = "Not your loan to delete"
            redirect "/loans#{@loan.id}"
        end
    end
end
