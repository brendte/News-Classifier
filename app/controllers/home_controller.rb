class HomeController < ApplicationController
  def index

  end

  def yesorno
    title_url ="http://access.alchemyapi.com/calls/url/URLGetTitle?apikey=2dca9a7577657ed330d2a99e2744a167f043b3c6&outputMode=json&url=#{params[:url]}"
    body_url = "http://access.alchemyapi.com/calls/url/URLGetText?apikey=2dca9a7577657ed330d2a99e2744a167f043b3c6&outputMode=json&url=#{params[:url]}"
    title_response = Typhoeus::Request.get(title_url)
    body_response = Typhoeus::Request.get(body_url)
    begin
      if title_response.code == 200 && body_response.code == 200
        @title = ActiveSupport::JSON.decode(title_response.body)['title']
        @body = ActiveSupport::JSON.decode(body_response.body)['text']
        Article.create!(:title => @title, :body => @body, :url => body_url, :publish_date => Time.now)
        bin_nb = UserNb.find_by_user('default').nb_obj
        nb = NB.new
        nb = Marshal.load(bin_nb)
        @yes_or_no = nb.classify(@body)
      else
        raise "Alchemy didn't show you any love"
      end
    rescue Exception => e
      flash[:error] = "Something went wrong: #{e}"
      redirect_to :root
    end

  end

end
