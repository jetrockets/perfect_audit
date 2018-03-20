module PerfectAudit
  class Book
    extend Dry::Initializer

    option :pk, optional: true
    option :created, optional: true
    option :name
    option :is_public, default: proc { false }
  end
end



