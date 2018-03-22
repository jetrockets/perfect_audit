FactoryBot.define do
  # factory :success_response, class: HTTP::Response do
  #   status 200
  #   version "1.1"
  #   body {
  #     JSON.dump({
  #       status: 200,
  #       msg: 'OK',
  #       response: {
  #         pk: 10399
  #       }
  #     })
  #   }
  # end

  factory :success_body, class: OpenStruct do
    status 200
    msg 'OK'
    response nil

    factory :books do
      transient do
        count 1
      end

      response do
        count == 1 ? {
          name: "Test Book",
          created: Time.now.to_s,
          is_public: false,
          pk: 1
        } : count.times.map {
          {
            name: "Test Book",
            created: Time.now.to_s,
            is_public: false,
            pk: 1
          }
        }
      end
    end
  end
end
