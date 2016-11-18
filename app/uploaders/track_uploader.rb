class TrackUploader < CarrierWave::Uploader::Base
  storage :fog

  # Only accept MP3 and WAV files.
  def extension_white_list
    %w(mp3 wav)
  end

  # Standardize file names! 
  # For example: sexy-back.justin-timberlake.futuresex/lovesounds
  def filename
    name = model.name
    artist = model.artist
    release = model.release
    filename = (name + '.' + artist + '.' + release).downcase.gsub(/\s/, '-')

    "#{filename}" if original_filename 
  end
end