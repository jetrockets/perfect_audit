require 'perfect_audit/api/book'

module PerfectAudit
  class BooksRepository
    include PerfectAudit::AutoInject[:connection]
    include PerfectAudit::AutoInject[:response_parser]

    def create(params)
      # book = PerfectAudit::Book.new(params)

      response = connection.post('book/add',
        json: params
      )

      response_parser.parse(response.body.to_s)
    end

    def find(id)
      response = connection.get('book/info',
        params: {
          pk: id
        }
      )

      response_parser.parse(response.body.to_s)
    end

    def documents
    end
  end
end
