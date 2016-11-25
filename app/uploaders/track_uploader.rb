class TrackUploader < CarrierWave::Uploader::Base
  storage :fog

  # Only accept MP3 and WAV files.
  def extension_white_list
    %w(mp3 wav)
  end

  # Standardize file names! 
  # For example: sexy-back_justin-timberlake_futuresex/lovesounds
  def filename
    filename = (model.name + '_' + model.artist + '_' + model.release).downcase.gsub(/\s/, '-')
    "#{filename}" if original_filename 
  end
end