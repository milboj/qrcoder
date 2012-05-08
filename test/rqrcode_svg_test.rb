require "test/unit"
require_relative "../lib/qrcoder.rb"

class QRCoder::QRCodeTest <Test::Unit::TestCase
  include QRCoder
  CURRENT_DIR = File.dirname(File.expand_path(__FILE__)) 

  def test_creating_png 
    output_file = CURRENT_DIR + "/new_test.png" 
    QRCode.image("test", CURRENT_DIR, { :format => :png , :filename => "new_test" })
    assert(File.exist?(output_file))
    File.delete(output_file)
  end
  
  def test_creating_png_with_larger  
    output_file = [{:size => "small", :unit => 11}, {:size => "medium" ,:unit => 20}, {:size => "large",:unit => 41}]
    output_file.each do |file|
      QRCode.image("test", CURRENT_DIR,  :format => :png , :filename => file[:size], :unit => file[:unit] )
      path = CURRENT_DIR + "/" + file[:size] + ".png"
      assert(File.exist?(path))
      image = MiniMagick::Image.open(path)
      assert_equal(image[:width], file[:unit] * 21) 
      File.delete(path)
    end
  end

  def test_creating_jpg 
    output_file = CURRENT_DIR + "/new_test.jpg" 
    QRCode.image("test", CURRENT_DIR, { :format => :jpg , :filename => "new_test", :unit => 40 })
    assert(File.exist?(output_file))
    File.delete(output_file)
  end
  
  def test_creating_svg 
    output_file = CURRENT_DIR + "/new_test.svg" 
    QRCode.image("tesfadsghjklghjklfghjklfghrgthjkmlfghjktghjkfghjkffghjkl", CURRENT_DIR, { :format => :svg , :filename => "new_test" })
    assert(File.exist?(output_file))
    File.delete(output_file)
  end

  def test_creating_multiple 
    formats = [:svg, :png, :jpg, :gif, :tif, :bmp]
    QRCode.image("tesfadsghjjklfghrgthjkmlfghjktghjkfghjkffghjkl", CURRENT_DIR, { :format => formats , :filename => "mulitple_test" })
    formats.each do |format|
      output_file = CURRENT_DIR + "/mulitple_test.#{format}" 
      assert(File.exist?(output_file))
      File.delete(output_file)
    end
  end

  def test_invalid_file_format 
    assert_raise QRCoder::QRCodeError do  
      QRCode.image("ghjk", CURRENT_DIR, {:format => :rtyui})
    end
  end
  
  def test_invalid_file_path 
    assert_raise QRCoder::QRCodeError do  
      QRCode.image("ghjk", "rtyufhadisuyiuds hfioh isufh", {:format => :png})
    end
  end

  def test_other_methods 
    formats = [:png, :jpg, :gif, :tif, :bmp]
    QRCode.bmp("tesfajkfghjkffghjkl", CURRENT_DIR, {:filename => "meta_test" })
    QRCode.png("tesfajkfghjkffghjkl", CURRENT_DIR, {:filename => "meta_test" })
    QRCode.jpg("tesfajkfghjkffghjkl", CURRENT_DIR, {:filename => "meta_test" })
    QRCode.gif("tesfajkfghjkffghjkl", CURRENT_DIR, {:filename => "meta_test" })
    QRCode.tif("tesfajkfghjkffghjkl", CURRENT_DIR, {:filename => "meta_test" })

    formats.each do |format|
      output_file = CURRENT_DIR + "/meta_test.#{format}" 
      assert(File.exist?(output_file))
      File.delete(output_file)
    end
  end

  
end
