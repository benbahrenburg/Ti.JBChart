<h1>Ti.JBChart</h1>

The Ti.JBChart project providers a wrapper around the [JBChartView](https://github.com/Jawbone/JBChartView).

![Animation](https://github.com/benbahrenburg/Ti.JBChart/blob/master/screenshots/demo.gif)

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

<h3>BarChartView</h3>

The <b>BarChartView</b> creates a bar chart from an array datasource you provide.

<h4>Properties</h4>

<b>data </b><i>required - Array</i> : An Array of the data to be displayed on the chart. See example section for details.  

<b>toolTipData </b><i>optional - Array</i> : An Array of the tool tip information that should be displayed. There should be one tool tip data array item for each of the data array items provided.


<b>selectionBarColor </b><i>optional - Color</i> : This property sets the color of the selection bar that is displayed when the user taps the chart.  This is white by default.

<b>barColors </b><i>optional - Array</i> : An Array of colors, with a color for each of the bars to be displayed.  If no bar color is available, a default of blue will be used.

<b>barColors </b><i>optional - Array</i> : An Array of colors, with a color for each of the bars to be displayed.  If no bar color is available of an data source index, a default of blue will be used.

<b>barPadding </b><i>optional - float</i> : The padding between bars in the chart.

<h4>Methods</h4>

<b>reloadData</b> : The reloadData is called after the chart has been rendered to reload the data provided to the views <b>data</b> property.

<h4>Example</h4>

<h3>AreaChartView</h3>

More details coming soon.  You can read the code now for all of the features.

<h3>LineChartView</h3>

More details coming soon.  You can read the code now for all of the features.

<h2>Module Properties</h2>

<b>CHART_LINE_SOLID</b> : This property is used set a solid line when displaying the LineChartView.

<b>CHART_LINE_DASHED</b> : This property is used set a dashed line when displaying the LineChartView.

<b>CHART_AREA_SMOOTH</b> : This property is used set a smooth area effect for the AreaChartView.

<b>CHART_AREA_DOTTED</b> : This property is used set a dotted area effect for the AreaChartView.

<h3>Twitter</h3>

If you like the Titanium module,please consider following the [@bencoding Twitter](http://www.twitter.com/bencoding) for updates.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).

<h3>Attribution</h3>

This project provides a Titanium wrapper for Jawbone's great graphing library [JBChartView](https://github.com/Jawbone/JBChartView).  
