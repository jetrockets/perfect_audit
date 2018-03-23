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
    EXCEL_EXPORT_PATH = 'book/export/xlsx/analytics'.freeze

    # Create book in Perfect Audit
    #
    # @param name [String] name of book
    # @param public [Boolean] should book be public ot not, `true` or `false`
    # @return [PerfectAudit::Book] newly created book
    # @raise [PerfectAudit::Error] if anything goes wrong during request
    def create(name, public = false)
      response = connection.post(CREATE_PATH,
        json: {
          name: name.to_s,
          is_public: public.to_s
        }
      )

      PerfectAudit::Book.new(response_parser.parse(response.body.to_s))
    end

    # Get all books from Perfect Audit for account
    #
    # @return [Array<PerfectAudit::Book>]
    # @raise [PerfectAudit::Error] if anything goes wrong during request
    def all
      response = connection.get(ALL_PATH)

      response_parser.parse(response.body.to_s).map{ |item|
        PerfectAudit::Book.new(item)
      }
    end


    # Find book in Perfect Audit
    #
    # @param id [Integer] ID of book
    # @return [PerfectAudit::Book]
    # @raise [PerfectAudit::Error] if anything goes wrong during request
    def find(id)
      response = connection.get(FIND_PATH,
        params: {
          pk: id.to_s
        }
      )

      PerfectAudit::Book.new(response_parser.parse(response.body.to_s))
    end

    # Delete book in Perfect Audit
    #
    # @param id [Integer] ID of book
    # @return [true]
    # @raise [PerfectAudit::Error] if anything goes wrong during request
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

    def to_excel(book_or_id)
      id = book_or_id.is_a?(PerfectAudit::Book) ? book_or_id.id.to_s : book_or_id.to_s
      response = connection.get(EXCEL_EXPORT_PATH,
        params: {
          pk: id.to_s
        }
      )

      response.body.to_s
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

  #   # def find(book_or_id)
  #   #   id = book_or_id.is_a?(PerfectAudit::Book) ? book_or_id.id.to_s : book_or_id.to_s

  #   #   response = connection.get('transaction',
  #   #     params: {
  #   #       book_pk: id
  #   #     }
  #   #   )

  #   #   response_parser.parse(response.body.to_s)[:bank_accounts].map do |id, params|
  #   #     PerfectAudit::BankAccount.new(params.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo})
  #   #   end
  #   # end

  #   def
  # end
end
