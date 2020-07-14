class User::DistrictsController < User::UserController
  def index
    province = Province.find(params[:provinceId])
    @districts = province.districts.search_districts(params[:district_name])
    respond_to do |format|
      format.html
      format.json { render json: { districts: @districts.as_json(only: [:id, :name]) } }
    end
  end
end
