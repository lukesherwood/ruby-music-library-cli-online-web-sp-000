require 'pry'
class Song
  attr_accessor :name
  attr_reader :artist, :genre #just moved this from accessor
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end
  
  def artist=(artist_name)
    @artist = artist_name
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
 def self.find_by_name(name)
    @@all.find do |song|
        song.name == name
    end
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename(filename)
    array = filename.chomp('.mp3').split(" - ")

    artist = Artist.find_or_create_by_name(array[0])
    genre = Genre.find_or_create_by_name(array[2])
    self.new(array[1], artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
end