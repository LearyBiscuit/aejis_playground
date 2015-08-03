RSpec.describe UsageCollection do
  let(:collection) { UsageCollection.new }

  context 'when pushed value valid' do
    let(:value) { { cpu: 5, ram: 40, time: Time.now.to_i } }
    
    describe '.push' do
      it 'should return :ok' do
        expect(collection.push(value)).to(eql(:ok))
      end
    end

    describe '.all' do
      before(:each) { collection.push(value) }

      it 'should contain given value' do
        expect(collection.all).to include(value)
      end
    end
  end

  context 'when pushed value invalid' do
    context 'and has different type' do
      let(:value) { 9 }

      describe '.push' do
        it 'should return :unprocessable_entity' do
          expect(collection.push(value)).to(eql(:unprocessable_entity))
        end
      end

      describe '.all' do
        before(:each) { collection.push(value) }

        it 'should not contain given value' do
          expect(collection.all).to eql([])
        end
      end    
    end

    context 'and has another structure' do
      let(:value) { { a: 5, ram: 43, time: Time.now.to_i } }

      describe '.push' do
        it 'should return :unprocessable_entity' do
          expect(collection.push(value)).to(eql(:unprocessable_entity))
        end
      end

      describe '.all' do
        before(:each) { collection.push(value) }

        it 'should not contain given value' do
          expect(collection.all).to eql([])
        end
      end
    end
  end
end