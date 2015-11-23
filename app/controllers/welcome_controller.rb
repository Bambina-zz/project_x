class WelcomeController < ApplicationController
  def home
    @errand = Errand.new
  end
end
