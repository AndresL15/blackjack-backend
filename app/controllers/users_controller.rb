class UsersController < ApplicationController

    before_action :set_user, only:[:show]
    before_action :set_user_j, only:[:join]
    before_action :set_user_n, only:[:login]
    before_action :set_game, only:[:join]

    def create
        @user = User.create(params_user)
        if @user.persisted?
            render status: 200, json: { token: @user.token }
        else
            render status: 404, json: { message: "No se pudo crear el user: #{ @user.errors.details }"}
        end
    end

    def show
        render status: 200, json: { user: @user }
    end

    def login
        if @user.blank? || @user.password != params[:password]
            render status: 404, json: { message: "Datos incorrectos"}
        elsif 
            render status: 200, json: { token: @user.token }
        end
    end

    def current
        @user = User.find_by(token: params[:token])
        if @user.blank?
            render status: 404, json: { message: "No se encontro ese user"}
        else
            render status: 200, json: { id: @user.id, name: @user.name }
        end
    end

    def join
        @game.users << @user
        if @user.update(params_join)
            render status: 200, json: { id: @game.id }
        else
            render status: 404, json: { message: "No pudo entrar al juego" }
        end
    end

    def logout
        render status: 200, json: { message: "Logout correcto"}
    end

    private
        
        def params_user
            params.require(:user).permit(:name, :password)
        end

        def params_join
            params.require(:user).permit(:game_id)
        end

        def set_user
            @user = User.find_by(id: params[:id])
            if @user.blank?
                render status: 404, json: { message: "No se encontro ese user: #{params[:id] }"}
                false
            end
        end

        def set_user_j
            @user = User.find_by(id: params[:user_id])
            if @user.blank?
                render status: 404, json: { message: "No se encontro ese user: #{params[:id] }"}
                false
            end
        end

        def set_user_n
            @user = User.find_by(name: params[:name])
            if @user.blank?
                render status: 404, json: { message: "No se encontro ese user: #{params[:name] }"}
                false
            end
        end     

        def set_game
            @game = Game.find_by(id: params[:game_id])
            if @game.blank?
                render status: 404, json: { message: "No se encontro ese juego #{params[:game_id] }"}
                false
            end
        end

end
