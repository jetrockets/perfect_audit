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
        count == 1 ? {
          name: Faker::Science.element,
          created: Faker::Time.backward(90),
          is_public: Faker::Boolean.boolean,
          pk: Faker::Number.number(5)
        } : count.times.map {
          {
            name: Faker::Science.element,
            created: Faker::Time.backward(90),
            is_public: Faker::Boolean.boolean,
            pk: Faker::Number.number(5)
          }
        }
      end
    end
  end
end
