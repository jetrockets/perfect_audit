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
  end
end
