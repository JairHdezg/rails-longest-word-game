class ApplicationController < ActionController::Base

  private

  def current_score
    @_current_score += session[:score]
  end
end
