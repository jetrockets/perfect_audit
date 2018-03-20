module PerfectAudit
  class Book
    extend Dry::Initializer

    include PerfectAudit::AutoInject[:connection]

    option :pk, optional: true
    option :created, optional: true
    option :name
    option :is_public, default: proc { false }

    def save
      connection.post('book/add',
        json: {
          name: name,
          is_public: is_public
        }
      )
    end
  end
end



