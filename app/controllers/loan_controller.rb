class LoanController < ApplicationController

    get '/loans' do
        if !!session[:id]
            erb :'/loans/index'
        else
            redirect '/login'
        end
    end

    get '/loans/new' do
        if !!session[:id]
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
            redirect '/loans/new'
        else
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
            #update loan.last_user once column added
            erb :'/loans/edit'
        else
            redirect '/login'
        end
    end

    patch '/loans/:id' do
        @loan = Loan.find(params[:id])
        @loan.update
        @loan.save
        redirect "/loans/#{@loan.id}"
    end

end
