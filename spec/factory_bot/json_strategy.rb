# frozen_string_literal: true

class JsonStrategy
  def initialize
    @strategy = FactoryBot.strategy_by_name(:create).new
  end

  delegate :association, to: :@strategy

  def result(evaluation)
    JSON.dump(@strategy.result(evaluation).to_h)
  end
end
