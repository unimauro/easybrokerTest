require_relative 'easyBrokerApi'

RSpec.describe EasyBrokerAPI do
  describe '#extract_titles' do
    it 'returns an array of property titles' do
      api = EasyBrokerAPI.new
      allow(api).to receive(:fetch_properties).and_return(
        {
          'content' => [
            { 'title' => 'Casa en Venta Amorada en Santiago Nuevo Leon' },
            { 'title' => 'Beautiful property in Condesa.' }
          ]
        }
      )
      expect(api.extract_titles).to eq(['Casa en Venta Amorada en Santiago Nuevo Leon', 'Beautiful property in Condesa.'])
    end
  end

  context 'when no properties are present' do
    it 'returns an empty array' do
      api = EasyBrokerAPI.new
      allow(api).to receive(:fetch_properties).and_return(
        { 'content' => [] }
      )
      expect(api.extract_titles).to eq([])
    end
  end

  describe '#fetch_properties' do
    it 'returns a hash with status 200' do
      api = EasyBrokerAPI.new
      response = double('response', code: '200', read_body: '{"content": []}')
      allow(api.instance_variable_get(:@http)).to receive(:request).and_return(response)
      expect(api.fetch_properties['status']).to eq(nil)
    end
  end

end
