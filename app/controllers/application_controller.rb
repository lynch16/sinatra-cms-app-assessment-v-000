require 'rack-flash'
class ApplicationController < Sinatra::Base
    use Rack::Flash
    register Sinatra::ActiveRecordExtension
    configure do
        enable :sessions
        set :session_secret, "my_application_secret"
        set :views, Proc.new { File.join(root, "../views/") }
    end

    get '/' do
        if !!session[:id]
            @user = User.find(session[:id])
            redirect '/loans'
        else
            erb :index
        end
    end

    get '/signup' do
        if !!session[:id]
            @user = User.find(session[:id])
            redirect '/loans'
        else
            erb :signup
        end
    end

    post '/signup' do
        @user = User.find_by(username: params[:username])
        if !!@user
            flash[:message] = "Username already exists"
            redirect '/login'
        else
            @user = User.new(params)
            if !@user.save
                if params[:username].empty?
                    flash[:message] = "Username invalid"
                else
                    flash[:message] = "Password invalid"
                end
                redirect '/signup'
            else
                session[:id] = @user.id
                @user.save
                redirect '/loans'
            end
        end
    end

    get '/login' do
        if !!session[:id]
            @user = User.find(session[:id])
            redirect 'loans'
        else
            erb :login
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if !@user
            flash[:message] = "Username invalid"
            redirect '/login'
        elsif !@user.authenticate(params[:password])
            flash[:message] = "Password invalid"
            redirect '/login'
        else
            session[:id] = @user.id
            redirect '/loans'
        end
    end

    get '/logout' do
        if !!session[:id]
            session.clear
        end
        redirect '/'
    end
end
