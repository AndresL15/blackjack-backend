class BlackjacksController < ApplicationController

    before_action :set_game, only:[:join, :refresh]
    before_action :set_user, only:[:join]
    
   

    private

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
                render status: 404, json: { message: "No se encontro ese jugador #{params[:user_id] }"}
                false
            end
        end

        def params_blackjack
            params.require(:blackjack).permit(:name)
        end
        
        def params_join
            params.require(:user).permit(:name)
        end
 
end
