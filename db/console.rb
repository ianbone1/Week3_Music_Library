require_relative('../models/Artist.rb')
require_relative('../models/Album.rb')
require('pry')

#empty the database to start fresh.
Album.delete_all
Artist.delete_all


artist1 = Artist.new({ 'name' => 'Amazing Artist 1' })
artist2 = Artist.new({ 'name' => 'Even Better Artist' })

#orive the artist saves
artist1.save()
artist2.save()

album1a = Album.new({ 'name' => 'Bangin Tunes', 'genre' => 'pop', 'artist_id' => artist1.id})
album1b = Album.new({ 'name' => 'Top Mosh', 'genre' => 'pop', 'artist_id' => artist1.id})
album2a = Album.new({ 'name' => 'Party Starters', 'genre' => 'pop', 'artist_id' => artist2.id})

#prove the album saves
album1a.save()
album1b.save()
album2a.save()

#proves the finds
found_artist = Artist.find_by_id(artist1.id)
found_album = Album.find_by_id(album1a.id)

#run the updates to force an update
artist1.update
album1a.update

albumlist = artist1.album_list
artistlist = album1a.artist

#list all of both
all_albums = Album.list_all
all_artists = Artist.list_all

#delete the albums an artist has then delete the album
album1a.delete
album1b.delete
artist1.delete

#delete an artist with albums
#checks if they have any, deletes them, then deletes the artist
artist2.delete

#should end with empty database tables
final_albums = Album.list_all
final_artists = Artist.list_all

binding.pry()
nil
