class FeedingsController < ApplicationController
  def index
    @feedings = Feeding.all
    @feeding = Feeding.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @feeding = Feeding.new(params[:post])

    respond_to do |format|
      if @feeding.save
        format.html { redirect_to(feedings_url, :notice => 'Feeding was successfully created.') }
        format.js
      else
        format.html { redirect_to(feedings_url) }
      end
    end
  end
end
