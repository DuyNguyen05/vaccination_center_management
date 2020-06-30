class User::VaccinesController < User::UserController
  before_action -> { authorize [:user, Vaccine] }
  def index
    @vaccines = Vaccine.search_vaccines(params[:vaccine_name]).newest
    respond_to do |format|
      format.html
      format.json { render json: { vaccines: @vaccines.as_json(only: [:name, :id]) } }
    end
  end
end
