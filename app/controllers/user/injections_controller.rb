class User::InjectionsController < User::UserController
  before_action :load_person, expect: [:show]
  include Wicked::Wizard
  steps :step_1, :step_2, :step_3, :step_4, :step_5

  def show
    render_wizard
  end

  private

  def load_person
    @injection_book = current_user_account.info_injection_book.injection_books.find(params[:user][:id])
  end
end
