
StyledOverlay is a UIView with styling options, extendable and preset action overlays.

![styledoverlaydemo](https://cloud.githubusercontent.com/assets/476994/20619644/ea161f4a-b2f5-11e6-900a-03cecd10321e.jpg)

# Usage

Here is a small example derived from the Demo project.

```swift
	let overlay = StyledLabelsOverlay(frame: CGRect(x:0,y:0,width:100,height:100))
        overlay.style = .roundedFixed(cornerRadius: 5)
        overlay.styleColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        overlay.centerLabel.attributedText = NSAttributedString(string: "Center Label")
        overlay.centerLabel.textColor = .white
	self.addSubview(overlay)
```

The code shows the labels overlay. You can also use action overlays of type ```Download```, ```Play``` and ```Encrypted```:

```swift
	let downloadActionOverlay = StyledActionOverlay(frame: CGRect(x:0,y:0,width:100,height:100))
        downloadActionOverlay.style = .roundedFixed(cornerRadius: 5)
        downloadActionOverlay.styleColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
	downloadActionOverlay.actionType = .download
	self.addSubview(downloadActionOverlay)
```

Extend the ```StyledBaseOverlay``` or ```StyledBase3Overlay``` if you want to use the styling and layout features as a basis for own specialisations.

# Installation

## CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your Podfile and add _StyledLabel_:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘10.0’

use_frameworks!
pod ‘StyledOverlay’
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file):

``` bash
$ open MyProject.xcworkspace
```

You can now `import StyledOverlay` framework into your files.

## Manually

[Download](https://github.com/Rehsco/StyledOverlay/archive/master.zip) the project and copy the `StyledOverlay` folder into your project to use it in.

# License (MIT)

Copyright (c) 2016-present - Martin Jacob Rehder, Rehsco

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
