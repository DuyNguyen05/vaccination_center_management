class User::WardsController < User::UserController
  def index
    district = District.find(params[:districtId])
    @wards = district.wards.search_wards(params[:ward_name])
    respond_to do |format|
      format.html
      format.json { render json: { wards: @wards.as_json(only: [:id, :name]) } }
    end
  end
end
