class ApplicationController < ActionController::Base

  before_action :set_hospital

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end


  private

  def set_hospital
    @hospital = current_user.hospital rescue nil
  end

end
