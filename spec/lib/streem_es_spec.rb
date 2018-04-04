require 'rails_helper'

describe StreemEs do
  subject { described_class.new }

  describe '#search' do
    context 'when passing invalid arguments' do
      it 'raises an invalid argument error' do
        expect{ subject.search }.to raise_error ArgumentError
      end
    end

    context 'when passing correct arguments' do
      before do
        allow(subject).to \
          receive(:build_page_url_match)
            .and_return({
              match: { page_url: 'someurl.com' }
            })

        allow(subject).to \
          receive(:request_body)
            .and_return({
              size: 0,
              query: {
                bool: {
                  must: []
                }
              }
            })

        allow(subject).to \
          receive_message_chain("client.search")
            .and_return({})
      end

      it 'calls the request_body method' do
        expect(subject).to receive(:request_body)
        subject.search('someindex')
      end

      it 'calls the build_page_url_match method' do
        expect(subject).to receive(:build_page_url_match)
        subject.search('someindex')
      end

      context 'when passing a before and after timestamp' do
        it 'calls the build_range method' do
          before = '343434'
          after = '23232312'

          expect(subject).to receive(:build_range).with(before, after)
          subject.search('someindex',page_url: 'somepageurl', after: after, before: before);
        end
      end
    end
  end
end