require 'rails_helper'

describe PageHit do
  describe '.search' do
    context 'when passing a nil url' do
      it 'returns an empty array' do
        expect(described_class.search).to eq []
      end
    end

    context 'when passing a url as string' do
      it 'raises an ArgumentError' do
        expect{ described_class.search 'some_url' }.to raise_error ArgumentError
      end
    end

    context 'when passing an empty url argument' do
      it 'returns an empty array' do
        expect(described_class.search []).to eq []
      end
    end

    context 'when passing a correct array of urls' do
      let(:sample_es_response) { { tool: 3 } }

      before do
        allow_any_instance_of(StreemEs).to receive(:search) { sample_es_response }
      end

      it 'returns an array of page hits of the urls' do
        expect(described_class.search ['sample_url.com']).to eq [sample_es_response]
      end
    end
  end
end