require 'rails_helper'

describe PageHit do
  describe '.search' do
    context 'when passing a url as string' do
      it 'returns an error' do
        expect(described_class.search('some_url').messages[:url]).to include 'should be an array of urls'
      end
    end

    context 'when passing an empty url string' do
      it 'returns an error' do
        expect(described_class.search('').messages[:url]).to include 'should be an array of urls'
      end
    end

    context 'when passing an empty before timestamp' do
      it 'returns an error' do
        expect(
          described_class.search(
            ['sample_url.com'],
            { before: '' }
          ).messages[:before]
        ).to include 'is required'
      end
    end

    context 'when passing an empty after timestamp' do
      it 'returns an error' do
        expect(
          described_class.search(
            ['sample_url.com'],
            { before: '' }
          ).messages[:after]
        ).to include 'is required'
      end
    end

    context 'when passing a valid parameters' do
      let(:url) { 'sample_url.com' }
      let(:sample_es_response) { { tool: 3 } }
      let(:search_result) do
        {
          "#{url}" => sample_es_response
        }
      end
      before do
        allow_any_instance_of(StreemEs).to receive(:search) { sample_es_response }
      end

      it 'returns an array of page hits of the urls' do
        expect(
          described_class.search(
            [url],
            { before: '12344', after: '12334', interval: '1m' }
          )
        ).to eq search_result
      end
    end
  end
end