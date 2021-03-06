require 'pry'
class MusicLibraryController 
  
  attr_accessor :path

  def initialize(path = './db/mp3s')
    @path = path 
    @import = MusicImporter.new(path).import
  end 
  
   
  def call 
    input = ""
    while input != "exit"
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip 
    case input 
      when 'list genres'
        list_genres 
      when 'list artists' 
        list_artists 
      when 'list songs'
        list_songs
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
      end 
  end
  
  
  def list_songs 
    Song.all.sort_by { |song| song.name }.each_with_index do |song, i| 
        puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" 
    end
  end 
  
  def list_artists 
    Artist.all.sort_by { |artist| artist.name }.each_with_index do |artist, i| 
        puts "#{i+1}. #{artist.name}"
  end
  end
  
  def list_genres 
    Genre.all.sort_by { |genre| genre.name }.each_with_index do |genre, i| 
        puts "#{i+1}. #{genre.name}" 
      end 
    end 
    
 def list_songs_by_artist 
   puts "Please enter the name of an artist:"
   artist = gets.chomp
    if found = Artist.find_by_name(artist) 
        found.songs.sort_by {|song| song.name}.each_with_index do
          |song, i| 
            puts "#{i+1}. #{song.name} - #{song.genre.name}" 
    end 
    end 
 end 
 
  def list_songs_by_genre 
    puts "Please enter the name of a genre:"
    genre = gets.chomp 
    if found = Genre.find_by_name(genre) 
      found.songs.sort_by {|song| song.name}.each_with_index do 
       |song, i| 
        puts "#{i+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end 
  
  def play_song 
    puts "Which song number would you like to play?"
    index = gets.chomp.to_i - 1
    if index < 0 || index >= Song.all.size 
    else
      song = Song.all.sort_by {|song| song.name}[index] 
      puts "Playing #{song.name} by #{song.artist.name}"
    end 
  end 
  
end 
 
 
 