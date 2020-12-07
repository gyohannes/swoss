class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @procedure_categories = ProcedureCategory.order('code')
  end
end
