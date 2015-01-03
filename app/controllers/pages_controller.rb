class PagesController < ApplicationController
  def instructions
    @title = 'Instructions'
    
    respond_to do |format|
      format.html
    end
  end
end
