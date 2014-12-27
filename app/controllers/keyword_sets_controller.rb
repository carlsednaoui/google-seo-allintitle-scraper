class KeywordSetsController < ApplicationController
  def new
    @keyword_set = KeywordSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyword_set }
    end
  end
  
  def create
    @keyword_set = KeywordSet.new
    @keyword_set.keywords = params[:keyword_set][:keywords]

    respond_to do |format|
      if @keyword_set.save
        format.html { redirect_to '/', notice: 'Keywords successfully created.' }
        format.json { render json: @keyword_set, status: :created, location: @keyword_set }
      else
        format.html { render action: "new" }
        format.json { render json: @keyword_set.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def keyword_set_params
      params.require(:keywords).permit(:keywords)
    end
end
