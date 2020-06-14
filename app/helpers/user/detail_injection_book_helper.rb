module User::DetailInjectionBookHelper
  def set_active_for_step current_step, params_step
    'active' if current_step >= params_step
  end
end
