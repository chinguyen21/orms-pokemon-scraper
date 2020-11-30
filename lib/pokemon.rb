class Pokemon
  attr_accessor :name, :type, :db, :id

  def initialize(name:, type:, db:, id:)
    @name = name
    @type = type
    @id = id
    @db = db
  end

  def self.save(name, type, db)
    sql =<<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?,?)
    SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]

  end

  def self.find(id, db)
    sql=<<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL
    row = db.execute(sql,id)[0]
    name = row[1]
    type = row[2]
    new_pokemon = Pokemon.new(name: name, type: type, db: db, id: id)
  end

end
