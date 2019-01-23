require_relative('../db/SQLRunner.rb')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def self.delete_all
    sql = 'DELETE FROM artists;'
    SQLRunner.execute(sql)
  end

  def self.find_by_id(the_id)
    sql = 'SELECT * from artists WHERE id = $1;'
    values = [the_id]
    results = SQLRunner.execute(sql, values)
    return Artist.new(results[0]) unless results.count == 0
  end

  def self.list_all
    sql = 'SELECT * from artists;'
    results = SQLRunner.execute(sql)
    return results.map {|artist| Artist.new(artist)} unless results.count == 0
  end

  def save
    sql = 'INSERT INTO artists (name) VALUES ($1) RETURNING id;'
    values = [@name]
    @id = SQLRunner.execute(sql, values)[0]['id'].to_i
  end

  def update
    sql = 'UPDATE artists SET name = $1 WHERE id = $2;'
    values = [@name, @id]
    SQLRunner.execute(sql, values)
  end

  def album_list
    sql = 'SELECT * FROM albums WHERE artist_id = $1;'
    values = [@id]
    results = SQLRunner.execute(sql, values)
    return results.map {|album| Album.new(album)} unless results.count == 0
  end

  def delete
    #check for albums
    albums = album_list()
    albums.each {|album| album.delete} unless albums == nil

    sql = 'DELETE FROM artists WHERE id = $1;'
    values = [@id]
    results = SQLRunner.execute(sql, values)
  end

end
