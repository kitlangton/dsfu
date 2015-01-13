module Serializer
  REGEX = /(\d+[\.\d]*)[ xX"]+(\d+[\.\d]*)/

  def self.serialize_raw_sizes
    raw_text = File.readlines(File.expand_path('../../../db/size_data_raw.txt', __FILE__))
    new_text = []
    raw_text.each do |line|
      REGEX.match(line)
      new_text << DSF::Size.new($1,$2)
    end
    File.write(File.expand_path('../../../db/sizes_serial', __FILE__), Marshal::dump(new_text.uniq))
  end
end
