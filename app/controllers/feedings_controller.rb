require "uri"
require "net/http"

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
      if activate_feeder && @feeding.save
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

      @feeder_create_nonces_url = @feeder_url + 'nonces/create'
      @feeder_use_nonces_url = @feeder_url + 'nonces/use'

      # get nonce from feeder
      @unsigned_nonce = Net::HTTP.get_response(URI.parse(@feeder_create_nonces_url)).body

      # sign nonce
      @signed_nonce = Digest::SHA2.hexdigest(@unsigned_nonce + @feeder_private_key)

      # post nonce back to feeder
      @post_response = Net::HTTP.post_form(URI.parse(@feeder_use_nonces_url), {"signed_nonce" => @signed_nonce}).body

      return @post_response == 'success'
    end
end
