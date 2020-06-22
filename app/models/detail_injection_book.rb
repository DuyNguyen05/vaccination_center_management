class DetailInjectionBook < ApplicationRecord
  STEPS = %w[waiting step_1 step_2 step_3 step_4 step_5]
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

  scope :newest, -> {order updated_at: :desc}

  def current_step
    self.status || STEPS.first
  end

  def next_step
    self.update status: STEPS[STEPS.index(current_step)+1]
  end

  def previous_step
    self.update status: STEPS[STEPS.index(current_step)-1]
  end

  def third_step?
    status == STEPS.third
  end

  def first_step?
    status == STEPS.first
  end

  def second_step?
    status == STEPS.second
  end

  def last_step?
    status == STEPS.last
  end

  def all_valid?
    STEPS.all? do |step|
      self.status = step
      valid?
    end
  end

end
