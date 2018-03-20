module PerfectAudit
  class Books
    include PerfectAudit::AutoInject[:connection]

    def create(params)
      PerfectAudit::Book.new(params).save
    end

    def find(id)
      connection.post('book/info',
        json: {
          pk: id
        }
      )
    end

    def documents
    end
  end
end
