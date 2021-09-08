FactoryBot.define do
  factory :task do
    name { 'test' }
    summary { 'testing tasks' }
    association :user
  end
end
