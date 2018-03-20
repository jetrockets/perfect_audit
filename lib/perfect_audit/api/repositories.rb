require 'perfect_audit/api/book'
require 'http/form_data'

module PerfectAudit
  class BooksRepository
    include PerfectAudit::AutoInject[:connection]
    include PerfectAudit::AutoInject[:response_parser]

    def create(params)
      # book = PerfectAudit::Book.new(params)

      response = connection.post('book/add',
        json: params
      )

      PerfectAudit::Book.new(response_parser.parse(response.body.to_s))
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

    def delete(book_or_id)
      id = book_or_id.is_a?(PerfectAudit::Book) ? book_or_id.id.to_s : book_or_id.to_s
      response = connection.post('book/remove',
        json: {
          book_id: id
        }
      )

      response_parser.parse(response.body.to_s)

      true
    end
  end

  class DocumentsRepository
    include PerfectAudit::AutoInject[:connection]
    include PerfectAudit::AutoInject[:response_parser]

    def create(book_or_id, file)
      id = book_or_id.is_a?(PerfectAudit::Book) ? book_or_id.id.to_s : book_or_id.to_s

      response = connection.post('book/add',
        form: {
          pk: id,
          upload: HTTP::FormData::File.new(file)
        }
      )

      response_parser.parse(response.body.to_s)

      true
    end
  end
end
