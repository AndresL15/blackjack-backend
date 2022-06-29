class GamesController < ApplicationController

    before_action :set_game, only:[:refresh, :newgame, :dragcard, :winner]
    before_action :set_user, only:[:dragcard, :stop]
    before_action :check_stop, only:[:dragcard, :stop]
    before_action :check_full_stop, only:[:winner]


    def index
        @games = Game.all
        render status: 200, json: { games: @games }
    end

    def create
        @game = Game.create(params_game)
        if @game.persisted?
            render status: 200, json: { message: "Se creo el juego correctamente" }
        else
            render status: 404, json: { message: "No se pudo crear el juego"}
        end
    end

    def refresh
        @players = @game.users
        render status: 200, json: { players: @players }
    end

    def newgame
        deck = [];
        tipos = ['C','D','H','S'];
        especiales = ['A','J','Q','K'];

        for i in 2..10 do
            for n in 0..3 do
                str = "#{i}#{tipos[n]}"
                deck.push(str)
            end
        end

        for i in 0..3 do
            for n in 0..3 do
                str = "#{especiales[n]}#{tipos[i]}"
                deck.push(str)
            end
        end
        
        ndeck = deck.shuffle
        fdeck = ndeck.join(",")

        if @game.update(deck: fdeck)
            render status: 200, json: { message: "Deck nuevo" }
        else
            render status: 404, json: { message: "No pudo crear el nuevo deck" }
        end
    end

    def dragcard
        deck = @game.deck.split(',')
        card = deck.pop
        v = card[0,(card.length - 1)]

        if v.to_i == 0
            if v == 'A'
                value = 11
            else
                value = 10
            end
        else
            value = v
        end

        ndeck = deck.join(",")

        points = @user.points
        points = "#{points.to_i + value.to_i}"
        if points.to_i > 21 
            @user.update(points: value, state: 1)
            render status: 200, json: { card: card, value: value }
        elsif @game.update(deck: ndeck) && @user.update(points: points)
            render status: 200, json: { card: card, value: points }
        else
            render status: 404, json: { message: "No pudo sacar una carta" }
        end
    end

    def stop
        state = 1
        if @user.update(state: state)
            render status: 200, json: { message: "El jugador se detuvo" }
        else
            render status: 404, json: { message: "No se pudo parar el state" }
        end
    end

    def winner
        players = @game.users
        if players[0].points > 21
            winner = players[1].name
        elsif players[1].points > 21
            winner = players[0].name
        elsif players[0].points < players[1].points
            winner = players[1].name
        else
            winner = players[0].name
        end   
    end

    def finish
        state = 1
        if @game.update(state: state)
            render status: 200, json: { message: "Se cerro el juego" }
        else
            render status: 404, json: { message: "No se pudo cerrar el juego" }
        end
    end

    private

        def params_game
            params.require(:game).permit(:name)
        end

        def set_game
            @game = Game.find_by(id: params[:game_id])
            if @game.blank?
                render status: 404, json: { message: "No se encontro ese juego #{params[:game_id] }"}
                false
            end
        end

        def set_user
            @user = User.find_by(id: params[:user_id])
            if @user.blank?
                render status: 404, json: { message: "No se encontro ese user: #{params[:id] }"}
                false
            end
        end

        def check_stop
            return if @user.state == nil
            render status: 404, json: { message: "Error al parar el juego" }
        end

        def check_full_stop
            players = @game.users
            return if players[0].state == 1 && players[1].state == 1
            render status: 404, json: { message: "Hay jugadores que todavia no se detienen" }
        end
        
end


