class CheckBeforeInjection < ApplicationRecord
  serialize :answer_question, Array
  belongs_to :detail_injection_book

  enum status: [:agree, :disagree]
end
