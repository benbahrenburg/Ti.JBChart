<h1>Ti.JBChart</h1>

The Ti.JBChart project providers a wrapper around the [JBChartView](https://github.com/Jawbone/JBChartView).

<h2>Before you start</h2>
* This is an iOS native module designed to work with Titanium SDK 3.3.0.GA
* This will only work with iOS <b>7</b> or greater
* Before using this module you first need to install the package. If you need instructions on how to install a 3rd party module please read this installation guide.

<h2>Download the compiled release</h2>

* [iOS Dist](https://github.com/benbahrenburg/Ti.JBChart/tree/master/iphone/dist)

<h2>Building from source?</h2>

If you are building from source you will need to do the following:

Import the project into Xcode:

* Modify the titanium.xcconfig file with the path to your Titanium installation
* When running this project from Xcode you might run into a compile issue. If this is the case you will need to update the titanium.xcconfig to include your username. See the below for an example:

~~~
TITANIUM_SDK = /Users/benjamin/Library/Application Support/Titanium/mobilesdk/osx/$(TITANIUM_SDK_VERSION)
~~~

<h2>Setup</h2>

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the Ti.JBChart module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

<h2>Importing the module using require</h2>
<pre><code>
var mod = require('ti.jbchart');
</code></pre>

<h2>Module Features</h2>

<h3>AreaChartView</h3>

More details coming soon.  You can read the code now for all of the features.

<h3>LineChartView</h3>

More details coming soon.  You can read the code now for all of the features.

<h2>Module Properties</h2>

<b>CHART_LINE_SOLID</b> : This property is used set a solid line when displaying the LineChartView.

<b>CHART_LINE_DASHED</b> : This property is used set a dashed line when displaying the LineChartView.


<h3>Twitter</h3>

If you like the Titanium module,please consider following the [@bencoding Twitter](http://www.twitter.com/bencoding) for updates.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).

<h3>Attribution</h3>

This project provides a Titanium wrapper for Jawbone's great graphing library [JBChartView](https://github.com/Jawbone/JBChartView).  
