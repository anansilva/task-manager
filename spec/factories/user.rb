FactoryBot.define do
  factory :user do
    email { 'test@test.com' }
    password { 'a very safe password' }
  end
end
