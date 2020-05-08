require 'rubygems'
require 'bundler/setup'
require 'rmagick'
require 'date'
require 'fileutils'
require 'mime/types'

assets_dir = File.expand_path("../assets/images", __dir__)
sub_dir = Date.today.strftime('%Y/%m')
output_dir = File.expand_path(sub_dir, assets_dir)

class AssetImage
  def initialize(filename, output_dir)
    @filename = filename
    @output_dir = output_dir
    @image = Magick::ImageList.new(filename)
    @extname = extname(filename, @image)
  end

  def extname(filename, image)
    extname = File.extname(filename)
    if extname then
      return extname
    end
    extname = MIME::Types[image.mime_type].flat_map(&:extensions).first
    if extname then
      return ".#{extname}"
    end
    return nil
  end
  
  def write()
    basename = File.basename(@filename, @extname)
    @image.auto_orient!
    thumb = @image.resize_to_fit(300, 300)
    thumb_name = "#{basename}-#{thumb.columns}x#{thumb.rows}#{@extname}"
    thumb.strip!
    thumb.write(File.expand_path(thumb_name, @output_dir))
    original_name = File.expand_path(File.basename(@filename), @output_dir)
    @image.strip!
    @image.write(original_name)
  end
end

if !ARGV[0] then
  puts '引数がありません'
  exit 1
end
target = ARGV[0]

if !File.exist?(target) then
  puts 'ファイルが見つかりません: ' + target
  exit 1
end

begin
  if !File.exist?(output_dir) then
    FileUtils.mkdir_p(output_dir)
  end
  AssetImage.new(target, output_dir).write()
rescue => e
  puts e.message
  exit 1
end
