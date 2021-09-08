FactoryBot.define do
  factory :task do
    summary { 'testing tasks' }
    association :user
  end
end
