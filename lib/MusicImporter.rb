require 'pry'
class MusicImporter

attr_accessor :path
@@files = []

def initialize(pathname)
  @path = pathname
end

def files
 Dir.entries(@path).select! {|entry| entry.end_with?(".mp3")}
end

def self.import(path)
  s = MusicImporter.new(path)
  @@files << s
end

def import
  self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

end