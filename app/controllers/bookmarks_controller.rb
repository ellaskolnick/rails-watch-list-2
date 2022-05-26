class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    mark = params[:bookmark]
    @bookmark.list = @list
    @movie = Movie.find(mark[:movie_id])
    @bookmark.movie = @movie
    if @bookmark.save
      redirect_to @list, notice: 'Bookmark Added'
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    @list = @bookmark.list
    redirect_to list_path(@list), notice: 'Bookmark Deleted'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :select_value, :movie)
  end
end
