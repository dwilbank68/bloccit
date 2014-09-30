FactoryGirl.define do
  factory :post do
    title "Post Title"
    body "Post bodies must be pretty long"
    user # calls the user factory
    topic { Topic.create(name: 'Topic name')}
  end
end