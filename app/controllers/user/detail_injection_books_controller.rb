class User::DetailInjectionBooksController < User::UserController
  before_action :load_person, expect: [:new, :show]
  before_action -> { authorize [:user, DetailInjectionBook] }, only: [:new, :show]
  include Wicked::Wizard
  steps :step_1, :step_2, :step_3, :step_4, :step_5

  def new
    render_wizard
  end

  def show
    render_wizard
  end

  private

  def load_person
    @injection_book = InjectionBook.find(params[:user][:id])
  end

  # def injection_params
  #   params.require(:injection).permit :vaccine_center
  # end
end
