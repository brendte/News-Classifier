class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order(:publish_date).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def toggle
    @article = Article.find(params[:id])
    @article.like = !@article.like?

    respond_to do |format|
      if @article.save
        #format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        #format.json { head :ok }
        format.js { render json: {'like' => "#{@article.like?}"}, status: :ok }
      else
        #format.html { render action: "edit" }
        #format.json { render json: @article.errors, status: :unprocessable_entity }
        format.js { render status: :unprocessable_entity }
      end
    end
  end

end
