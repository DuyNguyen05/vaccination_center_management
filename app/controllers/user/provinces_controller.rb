class User::ProvincesController < User::UserController
  def index
    @provinces = Province.search_provinces(params[:province_name])
    respond_to do |format|
      format.html
      format.json { render json: { provinces: @provinces.as_json(only: [:id, :name]) } }
    end
  end
end
