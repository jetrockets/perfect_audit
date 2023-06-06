# frozen_string_literal: true

FactoryBot.define do
  factory :success_body, class: OpenStruct do
    status { 200 }
    msg { 'OK' }
    response { nil }

    factory :books do
      transient do
        count { 1 }
      end

      response do
        (count == 1) ? {
          name: Faker::Science.element,
          created: Faker::Time.backward(days: 90),
          is_public: Faker::Boolean.boolean,
          pk: Faker::Number.number(digits: 5)
        } : count.times.map {
          {
            name: Faker::Science.element,
            created: Faker::Time.backward(days: 90),
            is_public: Faker::Boolean.boolean,
            pk: Faker::Number.number(digits: 5)
          }
        }
      end
    end

    factory :auth_token do
      access_token { 'access_token' }
      expires_in { 86400 }
      token_type { 'Bearer' }
    end
  end

  factory :access_denied, class: OpenStruct do
    status { 401 }

    error { 'access_denied' }
    error_description { 'Unauthorized' }
  end

  factory :server_error, class: OpenStruct do
    status { 500 }
    message { 'Internal Server Error' }
  end
end
