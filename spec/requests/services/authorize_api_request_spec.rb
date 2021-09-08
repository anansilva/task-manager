describe Services::AuthorizeApiRequest do
  describe '.call' do
    let(:user) { create(:user) }

    context 'when the token is empty' do
      it 'raises an error' do
        expect { described_class.call(headers: {}) }.to raise_error(Errors::AuthorizationTokenError)
      end
    end

    context 'when the token is invalid' do
      it 'raises an error' do
        headers = { 'Authorization' => 'zzzz' }

        expect { described_class.call(headers: headers) }.to raise_error(Errors::AuthorizationTokenError)
      end
    end

    context 'whent the token is valid' do
      before do
        allow(Services::DecodeJsonWebToken).to receive(:call).and_return({ user_id: user.id })
      end

      it 'does not raise an error' do
        headers = { 'Authorization' => 'abcd123' }

        result = described_class.call(headers: headers)

        expect(result).to eq(user)
      end
    end
  end
end
