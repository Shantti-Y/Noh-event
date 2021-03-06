# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do

   describe '#association' do
      context 'related to place' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:place)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that performer belongs to place' do
            event = create(:model_event)
            expect(event.place).to be_truthy
         end
      end

      context 'related to event_programs' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:event_programs)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event has many event_programs' do
            expect{ create(:model_event, :start_from_this) }.to change(EventProgram, :count).by(1)
         end
      end

      context 'related to programs through event_programs' do
         let(:event) { create(:model_event, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:programs)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated program from event' do
            expect(event.programs.first).to eq(event.event_programs.first.program)
         end
      end

      context 'related to tickets' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:tickets)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event has many user_events' do
            expect{ create(:model_event, :start_from_this) }.to change(Ticket, :count).by(1)
         end
      end

      context 'related to user_events' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:user_events)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event has many user_events' do
            expect{ create(:model_event, :start_from_this) }.to change(UserEvent, :count).by(1)
         end
      end

      context 'related to users through user_events' do
         let(:event) { create(:model_event, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:users)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated user from event' do
            expect(event.users.first).to eq(event.user_events.first.user)
         end
      end

      context 'destroying dependency' do
         let(:event) { create(:model_event, :start_from_this) }
         let(:another_event) { create(:another_event, :start_from_this) }
         before(:each) do
            event.destroy
         end

         it "doesn't delete relative place" do
            expect(event.place).to be_truthy
         end

         it 'deletes relative event_programs' do
            expect(event.event_programs.count).to eq(0)
         end

         it "doesn't delete not relative event_programs" do
            expect(another_event.event_programs.count).not_to eq(0)
         end

         it 'deletes relative tickets' do
            expect(event.tickets.count).to eq(0)
         end

         it "doesn't delete not relative tickets" do
            expect(another_event.tickets.count).not_to eq(0)
         end

         it 'deletes relative user_events' do
            expect(event.user_events.count).to eq(0)
         end

         it "doesn't delete not relative user_events" do
            expect(another_event.user_events.count).not_to eq(0)
         end
      end
   end

   describe '#validation' do
      let(:event) { build(:model_event) }

      it 'is valid with title, start_date, information, official_url, and published' do
         expect(event).to be_valid
      end

      context 'title' do
         it 'is invalid with empty title' do
            event.title = nil
            event.valid?
            expect(event.errors[:title]).to include("can't be blank")
         end
      end

      # REVIEW: boolean型の特徴としてなにかしら値があればtrueになるが、
      # =>      falseの場合は直接falseを入力しないといけない
      context 'published' do
         it 'is convert from any words to true value' do
            words = ['a', 12, true]
            words.each do |word|
               event.published = word
               expect(event.published).to eq(true)
            end
         end

         it 'returns false if false is inserted' do
            event.published = false
            expect(event.published).to eq(false)
         end

         it 'is invalid with nil' do
            event.published = nil
            event.valid?
            expect(event.errors[:published]).to include('is not included in the list')
         end
      end

      context 'open_date' do
         it 'is invalid when later than start_date' do
            event.open_date = event.start_date + 2
            event.valid?
            expect(event.errors[:open_date]).to include('should be earlier than start_date')
         end
      end

      context 'category' do
         it 'is valid with proper values' do
            valid_categories = ['能楽協会主催',
                                '能楽堂主催',
                                '能楽協会員出演',
                                '教室、セミナー',
                                'その他']
            valid_categories.each do |valid_category|
               event.category = valid_category
               expect(event).to be_valid
            end
         end

         it 'is invalid with improper values' do
            invalid_categories = ['のうがくきょうかいしゅさい',
                                  'Noh-gakudo Shusai',
                                  '$3hg7`@']
            invalid_categories.each do |invalid_category|
               event.category = invalid_category
               event.valid?
               expect(event.errors[:category]).to include('is not included in the list')
            end
         end
      end
   end

   describe '#method' do
      context 'set_value_on_category' do
         let(:event) { create(:model_event) }
         it 'gets specified value on category field as default' do
            expect(event.category).to eq('その他')
         end
      end
   end
end
