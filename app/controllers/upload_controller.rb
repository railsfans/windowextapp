class UploadController < ApplicationController
layout false

def uploadin

respond_to do |format|
	format.js
end
end

def uploadout
respond_to do |format|
	format.js
end
end

def upload
if params[:photo]
Boy.import(params[:photo])
end
respond_to do |format|
	format.json { render json: { :success=>true }, :content_type => 'text/html' }
end
end

end
