require_relative('../db/SQLRunner.rb')
require('pry')

class Album

  attr_accessor :name, :genre
  attr_reader :id, :artist_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM albums;'
    SQLRunner.execute(sql)
  end

  def self.find_by_id(the_id)
    sql = 'SELECT * from albums WHERE id = $1;'
    values = [the_id]
    results = SQLRunner.execute(sql, values)
    return Album.new(results[0]) unless results.count == 0
  end

  def self.list_all
    sql = 'SELECT * from albums;'
    results = SQLRunner.execute(sql)
    return results.map {|album| Album.new(album)} unless results.count == 0
  end

  def self.list_all_by_artist_id(the_id)
    sql = 'SELECT * FROM albums WHERE artist_id = $1;'
    values = [the_id]
    results = SQLRunner.execute(sql, values)
    return results.map {|album| Album.new(album)} unless results.count == 0
  end

  def save
    sql = 'INSERT INTO albums (name, genre, artist_id) VALUES
    ( $1, $2, $3 ) RETURNING id;'
    values = [@name, @genre, @artist_id]
    @id = SQLRunner.execute(sql, values)[0]['id'].to_i
  end

  def update
    sql = 'UPDATE albums SET (name, genre, artist_id) = ( $1, $2, $3) WHERE id = $4;'
    values = [@name, @genre, @artist_id, @id]
    SQLRunner.execute(sql, values)
  end

  def artist
    sql = 'SELECT * FROM artists WHERE id = $1;'
    values = [@artist_id]
    results = SQLRunner.execute(sql, values)
    return Artist.new(results[0]) unless results.count == 0
  end

  def delete
    sql = 'DELETE FROM albums WHERE id = $1;'
    values = [@id]
    results = SQLRunner.execute(sql, values)
  end

end
