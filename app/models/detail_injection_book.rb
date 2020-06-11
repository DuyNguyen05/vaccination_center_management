class DetailInjectionBook < ApplicationRecord
  attr_writer :current_step

  has_one :bill, dependent: :destroy
  has_one :check_before_injection, dependent: :destroy
  belongs_to :vaccination_center, optional: true
  belongs_to :account, optional: true
  belongs_to :injection_book

  accepts_nested_attributes_for :bill
  accepts_nested_attributes_for :check_before_injection

  validates :injection_date, presence: true, on: :step_1
  validates :react_after_injection, presence: true, on: :step_4

  validates_presence_of :injection_date, :if => lambda { |o| o.status == "step_1" }
  validates_presence_of :react_after_injection, :if => lambda { |o| o.status == "step_4" }

  def current_step
    self.status || steps.first
  end

  def steps
    %w[step_1 step_2 step_3 step_4 step_5]
  end

  def next_step
    byebug
    self.update! status: steps[steps.index(current_step)+1]
  end

  def previous_step
    self.update! status: steps[steps.index(current_step)+1]
  end

  def first_step?
    status == steps.first
  end

  def last_step?
    status == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.status = step
      valid?
    end
  end

end
