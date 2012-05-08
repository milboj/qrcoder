require 'rqrcode'
require 'qrcoder/size_calculator.rb'
require 'qrcoder/renderers/svg.rb'
require 'mini_magick'

module QRCoder
  extend SizeCalculator

  class QRCodeError < StandardError; end

  class QRCode 
    IMAGE_FORMATS = [:jpg , :png, :gif, :tif, :bmp]

    class << self

      # 
      # Create qr image or images 
      #
      # == Parameters
      #
      # * text    <tt>String</tt> -- String for qrcode
      # * output  <tt>String</tt> -- String for path where to save files
      # * options <tt>Hash</tt>   -- Hash with options
      #
      # === Options  
      #
      # * :format   - Array or symbol. Allowed formats are :png, :bmp, :svg, :jpg, :gif and :tif
      # * :filename - String for filename without extension. Extension will be added automaticly.
      # * :size     - This controls how big the QR Code will be. Smallest size will be chosen by default. Set to maintain consistent size.
      # * :level    - The error correction level, can be:
      #   * Level :l 7%  of code can be restored
      #   * Level :m 15% of code can be restored
      #   * Level :q 25% of code can be restored
      #   * Level :h 30% of code can be restored (default :h) 
      # * :offset - Padding around the QR Code (e.g. 10)
      # * :unit   - How many pixels per module (e.g. 11)
      # * :fill   - Background color (e.g "ffffff" or :white)
      # * :color  - Foreground color for the code (e.g. "000000" or :black)
      #
      # === Example 
      # 
      #  QRCode.image("some text", "/home/user/", :format => [:png, :svg], :filename => "simple_test" 
      #  QRCode.image("some text", "/home/user/", :format => :png, :filename => "simple_test" , :unit => 12
      #
      def image text, output, options
        formats = []
        if options[:format].kind_of? Array
          formats = options[:format]
        else
          formats << options[:format] || :png
        end
        filename = options[:filename] || text
        svg      = self.svg(text, options)

        err_f = formats - IMAGE_FORMATS - [:svg]
        raise QRCodeError.new("#{err_f.join(', ')} is not supported file formats") unless(err_f.empty?)

        begin 
          formats.each do |format|
            if IMAGE_FORMATS.include?(format)
              image = MiniMagick::Image.read(svg) { |i| i.format "svg" }
              image.format format.to_s
              image.write "#{output}/#{filename}.#{format}"
            else
              data = svg
              file = File.new("#{output}/#{filename}.#{format}", "w")
              file.write(data)
              file.close
            end
          end
        rescue 
          raise QRCodeError.new "File saving error"
        end
      end

      # Create qr code svg output response 
      # * text    <tt>String</tt> -- String for qrcode
      # * options <tt>Hash</tt>   -- Hash with options
      #
      # === Options  
      #
      # * :format   - Array or symbol. Allowed formats are :png, :bmp, :svg, :jpg, :gif and :tif
      # * :filename - String for filename without extension. Extension will be added automaticly.
      # * :size     - This controls how big the QR Code will be. Smallest size will be chosen by default. Set to maintain consistent size.
      # * :level    - The error correction level, can be:
      #   * Level :l 7%  of code can be restored
      #   * Level :m 15% of code can be restored
      #   * Level :q 25% of code can be restored
      #   * Level :h 30% of code can be restored (default :h) 
      # * :offset - Padding around the QR Code (e.g. 10)
      # * :unit   - How many pixels per module (e.g. 11)
      # * :fill   - Background color (e.g "ffffff" or :white)
      # * :color  - Foreground color for the code (e.g. "000000" or :black)
      #
      def svg text, options ={}
        size   = options[:size]  || QRCoder.minimum_qr_size_from_string(text)
        level  = options[:level] || :h
        qrcode = RQRCode::QRCode.new(text, :size => size, :level => level)
        QRCoder::Renderers::SVG::render(qrcode, options)
      end


      IMAGE_FORMATS.each do |format| 
        define_method format.to_s do |text, output, options|
          options[:format] = [format]
          self.image text, output, options
        end
      end
    end
  end

end
