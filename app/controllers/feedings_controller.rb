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

  def test_feeder # for testing; todo: remove
    render :text => activate_feeder
  end

  private

    def activate_feeder
      # get environment variables
      @feeder_url = ENV['FEEDER_URL']
      @feeder_private_key = ENV['FEEDER_PRIVATE_KEY']

      @feeder_url + @feeder_private_key


      # Net::HTTP.get_response(uri)
      # get nonce from feeder
      # sign nonce
      # post nonce back to feeder
    end
end
