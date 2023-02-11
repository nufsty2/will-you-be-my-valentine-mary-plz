class PagesController < ApplicationController
  def home
    @input_string = params[:input_string]
  end
end
