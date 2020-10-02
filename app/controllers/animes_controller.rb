class AnimesController < ApplicationController
  # 「before_action :(〜ではない場合), only[閲覧制限ページ]」
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  # >> 一般ユーザー：index(一覧), show(詳細), search(ソート検索)のみ可能

  def index
    @animes = Anime.paginate(page: params[:page], per_page: 10)
  end

  def favorite_users
    @anime = Anime.find(params[:id])
    @favorites = Favorite.where(anime_id: @anime.id).paginate(page: params[:page], per_page: 10)
    # @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end

  def show
    @anime = Anime.find(params[:id])
    @favorites = Favorite.where(anime_id: @anime.id).all
  end

  def new
    @anime = Anime.new
  end

  def create
    @animes = Anime.paginate(page: params[:page], per_page: 10)
    @anime = Anime.new(anime_params)
    if @anime.save
      #アニメデータ作成成功
      flash[:success] = "アニメデータの作成に成功しました"
      redirect_to animes_path
    else
      #アニメデータ作成失敗
      flash[:danger] = "アニメデータの作成に失敗しました"
      redirect_to animes_path
      # render 'index'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    Anime.find(params[:id]).destroy
    flash[:success] = "アニメデータが削除されました"
    redirect_to animes_url
  end

  def search
    selection = params[:keyword]
    @animes = Anime.sort(selection)
    # @animes = @animes.paginate(page: params[:page], per_page: 10)
  end

  private

    def anime_params
      # params.require(:anime).permit(:title, :image, :description, :furigana)
      params.permit(:title, :image, :description, :furigana)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
