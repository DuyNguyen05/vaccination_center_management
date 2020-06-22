class CheckBeforeInjection < ApplicationRecord
  extend Enumerize
  serialize :answer_question, Array
  belongs_to :detail_injection_book

  enumerize :status, in: [:agree, :disagree], predicates: true, i18n_scope: "status", default: :disagree

  validates :status, presence: true
  validates :answer_question, presence: true, :if => lambda { |o| o.detail_injection_book.status == "step_2" }
end
