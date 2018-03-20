module PerfectAudit
  class BankAccount
    extend Dry::Initializer

    option :pk, as: :id
    option :account_type#, optional: true
    option :account_holder#, optional: true
    option :account_number#, optional: true
    option :holder_zip#, optional: true
    option :holder_state#, optional: true
    option :holder_city#, optional: true
    option :holder_address_1#, optional: true
    option :holder_address_2#, optional: true
  end
end
