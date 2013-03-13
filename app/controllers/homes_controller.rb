class HomesController < ApplicationController
  # GET /home
  def show
    @articles = current_user.articles.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

end
