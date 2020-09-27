class FavoritesController < ApplicationController

  def create
    anime = Anime.find(params[:anime_id])
    current_user.addfav(anime)
    flash[:success] = "登録完了しました！"
    redirect_to anime_path(anime)
  end

  def destroy
    anime = Anime.find(params[:anime_id])
    current_user.removefav(anime)
    flash[:success] = "登録解除しました！"
    redirect_to anime_path(anime)
  end
end
