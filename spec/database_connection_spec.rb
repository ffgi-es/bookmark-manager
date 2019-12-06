require 'database_connection'

describe DatabaseConnection do
  describe '#setup' do
    it "should try to connect to a postgres database" do
      expect(PG).to receive(:connect).with ( {dbname: 'test'} )
      DatabaseConnection.setup('test')
    end

    it "should set a connection to the database" do
      expect(DatabaseConnection.setup('bookmark_manager_test').db).to eq 'bookmark_manager_test'
    end
  end
end
