class DatabaseConnection
  def self.setup(name)
    @connection = PG.connect dbname: name
  end
end
