module PerfectAudit
  class Document
    extend Dry::Initializer

    STATUSES = %w(
      queued
      failed
      verifying
      verification_complete
      deleting
      deleted
      rejected
    )

    option :pk
    option :pages
    option :status, proc(&:downcase)
    option :name

    STATUSES.each do |s|
      define_method "#{s}?" do
        status == s
      end
    end
  end
end
