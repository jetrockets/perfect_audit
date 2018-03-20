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

    def all
      response = connection.get('books')

      response_parser.parse(response.body.to_s).map{ |item|
        PerfectAudit::Book.new(item)
      }
    end

    def find(id)
      response = connection.get('book/info',
        params: {
          pk: id
        }
      )

      PerfectAudit::Book.new(response_parser.parse(response.body.to_s))
    end
  end
end
