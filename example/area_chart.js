
var chart = require('ti.jbchart');
Ti.API.info("module is => " + chart);

function getRandomData(){
	var results =[],
		fakeLimit = 12;
		
	function randomIntFromInterval(min,max){
	    return Math.floor(Math.random()*(max-min+1)+min);
	}	
	for (var iLoop=0;iLoop<fakeLimit;iLoop++){
		results.push(randomIntFromInterval(1,12));
	}	
	return results;
};
	
exports.createWindow = function(){	
	var tipData = [],
		fakeData = [];
	
	var win = Ti.UI.createWindow({
		backgroundColor:'#fff',barColor:"#999",
		title:"Area Chart Demo"
	});
	

	for (var iLoop=0;iLoop<11;iLoop++){
		tipData.push("Tip " + (iLoop + 1));
	}	
	
	fakeData.push(getRandomData());
	fakeData.push(getRandomData());
		
	var areaChart = chart.createAreaChartView({
		width:Ti.UI.FILL,
		height:250, top:50,
		data : fakeData,
		toolTipData : tipData,
		selectedLineColor :['red','blue'],
		selectedFillColor :['yellow','purple'],
		//lineColor:['green','orange'],
		fillColor:['green','red']
		// chartBackgroundColor:'#000'
	});
	win.add(areaChart);
	
	areaChart.addEventListener('selected',function(e){
		Ti.API.info(JSON.stringify(e));
	});
	
	areaChart.addEventListener('unselected',function(e){
		Ti.API.info(JSON.stringify(e));
	});	
			
	return win;
};

