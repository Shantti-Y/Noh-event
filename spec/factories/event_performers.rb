require 'factory_girl'

FactoryGirl.define do
   factory :model_event_performer, class: EventPerformer do
      association :performer, factory: :model_performer
      association :event_program, factory: :model_event_program
   end

   factory :another_event_performer, class: EventPerformer do
      association :performer, factory: :another_performer
      association :event_program, factory: :another_event_program
   end

   factory :controller_event_performer, class: EventPerformer do
      association :performer, factory: :controller_performer
      association :event_program, factory: :controller_event_program
   end

   factory :different_event_performer, class: EventPerformer do
      association :performer, factory: :different_performer
      association :event_program, factory: :different_event_program
   end

   factory :first_search_event_performer, class: EventPerformer do
      association :performer, factory: :first_search_performer
      association :event_program, factory: :first_search_event_program
   end

   factory :second_search_event_performer, class: EventPerformer do
      association :performer, factory: :first_search_performer
      association :event_program, factory: :second_search_event_program
   end

   factory :third_search_event_performer, class: EventPerformer do
      association :performer, factory: :first_search_performer
      association :event_program, factory: :third_search_event_program
   end

   factory :fourth_search_event_performer, class: EventPerformer do
      association :performer, factory: :second_search_performer
      association :event_program, factory: :fourth_search_event_program
   end

   factory :fifth_search_event_performer, class: EventPerformer do
      association :performer, factory: :second_search_performer
      association :event_program, factory: :fifth_search_event_program
   end
end
