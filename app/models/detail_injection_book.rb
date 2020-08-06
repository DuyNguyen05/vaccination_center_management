class DetailInjectionBook < ApplicationRecord
  STEPS = %w[waiting step_1 step_2 step_3 step_4 step_5 cancel]
  attr_writer :current_step

  has_one :bill, dependent: :destroy
  has_one :check_before_injection, dependent: :destroy
  belongs_to :vaccination_center, optional: true
  belongs_to :account, optional: true
  belongs_to :injection_book

  accepts_nested_attributes_for :bill
  accepts_nested_attributes_for :check_before_injection

  validates_presence_of :injection_date, :if => lambda { |o| o.status == "step_1" }
  validates_presence_of :react_after_injection, :if => lambda { |o| o.status == "step_5" }

  validate :format_react_after_injection, if: :react_after_injection

  scope :newest, -> {order updated_at: :desc}

  def current_step
    self.status || STEPS.first
  end

  def next_step
    self.update status: STEPS[STEPS.index(current_step)+1] unless self.last_step? || self.cancel?
  end

  def previous_step
    self.update status: STEPS[STEPS.index(current_step)-1]
  end

  def second_step?
    status == STEPS.third
  end

  def waiting_step?
    status == STEPS.first
  end

  def first_step?
    status == STEPS.second
  end

  def third_step?
    status == STEPS[3]
  end

  def fouth_step?
    status == STEPS[4]
  end

  def last_step?
    status == STEPS[5]
  end

  def cancel?
    status == STEPS[6]
  end

  def all_valid?
    STEPS.all? do |step|
      self.status = step
      valid?
    end
  end

  def format_react_after_injection
    unless !last_step?
      return if time_after_injection  <= Time.now
      errors.add(:react_after_injection, I18n.t("errors.messages.time_invalid"))
    end
  end
end
