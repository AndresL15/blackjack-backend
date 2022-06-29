class UsersController < ApplicationController

    before_action :set_user, only:[:show, :stop]
    before_action :set_user_n, only:[:login]
    before_action :check_token, only:[:stop]

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
        else
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

    def logout
        render status: 200, json: { message: "Logout correcto"}
    end

    def stop
        state = 1
        if @user.update(state: state)
            render status: 200, json: { message: "El jugador se detuvo" }
        else
            render status: 404, json: { message: "No se pudo parar el state" }
        end
    end

    private
    
        def params_user
            params.require(:user).permit(:name, :password)
        end

        def set_user
            @user = User.find_by(id: params[:id])
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

        def check_token
            return if request.headers["Authorization"] == "Bearer " + @user.token
            render status: 401, json: { message: "Jugador no autorizado"}
            false
        end

end
