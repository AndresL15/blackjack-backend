class GamesController < ApplicationController

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

    private

        def params_game
            params.require(:game).permit(:name)
        end
        
end


