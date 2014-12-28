class PagesController < ApplicationController
  def instructions
    respond_to do |format|
      format.html
    end
  end
end
