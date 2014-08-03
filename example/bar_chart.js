
var chart = require('ti.jbchart');
Ti.API.info("module is => " + chart);

function randomIntFromInterval(min,max){
    return Math.floor(Math.random()*(max-min+1)+min);
}	
	
exports.createWindow = function(){	
	var tipData = [],
		fakeData = [],
		colorData =[];
	
	var win = Ti.UI.createWindow({
		backgroundColor:'#fff',barColor:"#999",
		title:"Bar Chart Demo"
	});
	
	for (var iLoop=0;iLoop<12;iLoop++){
		tipData.push("Tip " + (iLoop + 1));
		fakeData.push(randomIntFromInterval(1,12));
		colorData.push((iLoop % 2 == 0) ? 'blue' : 'green');
	}	

	var barChart = chart.createBarChartView({
		width:Ti.UI.FILL, height:250, top:50,
		data : fakeData,
		toolTipData : tipData,
		barCount : fakeData.length,
		barColors:colorData
		// chartBackgroundColor:'#000'
	});
	win.add(barChart);
	
	barChart.addEventListener('selected',function(e){
		Ti.API.info(JSON.stringify(e));
	});
	
	barChart.addEventListener('unselected',function(e){
		Ti.API.info(JSON.stringify(e));
	});	
	
	// win.addEventListener('open',function(d){		
		// setTimeout(function(){
			// barChart.reloadData();
		// },1000);
	// });
				
	return win;
};
