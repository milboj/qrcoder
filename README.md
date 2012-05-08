# Creates QR codes images 

This library is fork of Sam Vincent rqrcode-rails3 https://github.com/samvincent/rqrcode-rails3
Dependes on mini_magic and [rqrcode](https://github.com/whomwah/rqrcode) 

This gem supports generating QR images in SVG, BMP, TIF, JPG, GIF and PNG format. 

## Installation

Add the following to your +Gemfile+.

    gem 'rqrcoder'

or 

    gem install rqrcoder

## How to use

### Image method 

If you use image method you must define output format. 

Allowed formats are 
  
  * png 
  * bmp 
  * svg 
  * jpg
  * gif 
  * tif

  QRCode.image(text, output, options)

Examples 

    QRCode.image("some text", "/home/user/", :format => [:png, :svg], :filename => "simple_test" 
    QRCode.image("some text", "/home/user/", :format => :png, :filename => "simple_test" , :unit => 12

### SVG output
  
Return svg output 

    QRCode.svg(text, output, options)

Example

    QRCode.svg("some text", "/home/user", :filename => "simple_test", :unit => 12) 

### Other methods

You can use other methods
  
    QRCode.bmp(text, output, options)
    QRCode.png(text, output, options)
    QRCode.jpg(text, output, options)
    QRCode.tif(text, output, options)
    QRCode.gif(text, output, options)
  
#### Options:

* `:size`   – This controls how big the QR Code will be. The smallest size will be chosen by default. Set to maintain consistent size.
* `:level`  – The error correction level, can be:
  * Level `:l` 7%  of code can be restored
  * Level `:m` 15% of code can be restored
  * Level `:q` 25% of code can be restored
  * Level `:h` 30% of code can be restored (default :h) 
* `:offset` – Padding around the QR Code (e.g. 10)
* `:unit`   – How many pixels per module (e.g. 11)
* `:fill`   – Background color (e.g "ffffff" or :white)
* `:color`  – Foreground color for the code (e.g. "000000" or :black)
  
## About

This library is fork of Sam Vincent [rqrcode-rails3](https://github.com/samvincent/rqrcode-rails3)

QR codes are encoded by [rqrcode](https://github.com/whomwah/rqrcode)
