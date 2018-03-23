require 'perfect_audit/api/book'
require 'http/form_data'

module PerfectAudit
  class BooksRepository
    include PerfectAudit::AutoInject[:connection]
    include PerfectAudit::AutoInject[:response_parser]

    CREATE_PATH = 'book/add'.freeze
    ALL_PATH = 'books'.freeze
    FIND_PATH = 'book/info'.freeze
    DELETE_PATH = 'book/remove'.freeze

    def create(name, public = false)
      response = connection.post(CREATE_PATH,
        json: {
          name: name.to_s,
          is_public: public.to_s
        }
      )

      PerfectAudit::Book.new(response_parser.parse(response.body.to_s))
    end

    def all
      response = connection.get(ALL_PATH)

      response_parser.parse(response.body.to_s).map{ |item|
        PerfectAudit::Book.new(item)
      }
    end

    def find(id)
      response = connection.get(FIND_PATH,
        params: {
          pk: id.to_s
        }
      )

      PerfectAudit::Book.new(response_parser.parse(response.body.to_s))
    end

    def delete(book_or_id)
      id = book_or_id.is_a?(PerfectAudit::Book) ? book_or_id.id.to_s : book_or_id.to_s
      response = connection.post(DELETE_PATH,
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

    CREATE_PATH = 'book/upload'.freeze

    def create(book_or_id, file)
      id = book_or_id.is_a?(PerfectAudit::Book) ? book_or_id.id.to_s : book_or_id.to_s

      response = connection.post(CREATE_PATH,
        form: {
          pk: id,
          upload: HTTP::FormData::File.new(file)
        }
      )

      response_parser.parse(response.body.to_s)

      true
    end
  end

  # class TransactionsRepository
  #   include PerfectAudit::AutoInject[:connection]
  #   include PerfectAudit::AutoInject[:response_parser]

  #   def find(book_or_id)
  #     id = book_or_id.is_a?(PerfectAudit::Book) ? book_or_id.id.to_s : book_or_id.to_s

  #     response = connection.get('transaction',
  #       params: {
  #         book_pk: id
  #       }
  #     )

  #     response_parser.parse(response.body.to_s)[:bank_accounts].map do |id, params|
  #       PerfectAudit::BankAccount.new(params.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo})
  #     end
  #   end
  # end
end
