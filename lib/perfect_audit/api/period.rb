# frozen_string_literal: true

module PerfectAudit
  class Period
    extend Dry::Initializer

    option :pk, as: :id
    option :begin_date, proc { |v| Date.parse(v) }
    option :end_date, proc { |v| Date.parse(v) }
    option :begin_balance, proc(&:to_f)
    option :end_balance, proc(&:to_f)
    option :primary_recon_error_reason
    option :secondary_recon_error_reason
  end
end
