
var chart = require('ti.jbchart'),
	timerId = null,
	weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        
function getRandomData(){
	var results =[],
		fakeLimit = 7;
		
	function createRandom(min,max){
	    return Math.random() * (max - min) + min;
	}
	
	for (var iLoop=0;iLoop<fakeLimit;iLoop++){
		results.push(createRandom(1,12));
	}	
	return results;
};
	
exports.createWindow = function(){	
	var fakeData = [];

	var win = Ti.UI.createWindow({
		backgroundColor:'#404041',barColor:"#000",
		title:"Line Chart Demo", 
		orientationModes: [Ti.UI.PORTRAIT,Ti.UI.UPSIDE_PORTRAIT,Ti.UI.LANDSCAPE_LEFT,Ti.UI.LANDSCAPE_RIGHT ],
		titleAttributes:  {
	        color:'#fff'
	   },
	   layout: "vertical"
	});
		
	fakeData.push(getRandomData());
	fakeData.push(getRandomData());
	
	win.add(Ti.UI.createLabel({
		top:0, height:Ti.UI.SIZE,width:Ti.UI.FILL,
		text:'Rotate your device',
		textAlign:'center', color:'#fff',
		font:{
			fontSize:16,
			fontWeight:'bold'
		}		
	}));
			
	var lineChart = chart.createLineChartView({
		width:Ti.UI.FILL, height:200, top:10,
		data : fakeData,
		toolTipData : weekdays,
		styles :[chart.CHART_LINE_SOLID,chart.CHART_LINE_DASHED],
		selectedLineColors :['yellow','orange'],
		lineColors:['green','blue'],
		selectionBarColor:'#fff',
		chartBackgroundColor:'#505051'
	});
	win.add(lineChart);

	var infoView = Ti.UI.createView({
		left:10, right:10, top:20, height:150
	});
	win.add(infoView);
	
	var dataTypeLabel = Ti.UI.createLabel({
		height:25, width:Ti.UI.FILL, top:0,left:0,
		textAlign:'left', color:'#fff',
		font:{
			fontSize:24,
			fontWeight:'bold'
		}
	});	
	infoView.add(dataTypeLabel);
		
	var infoLabel = Ti.UI.createLabel({
		height:Ti.UI.FILL, width:Ti.UI.FILL, top:25,
		textAlign:'center', color:'#fff',
		font:{
			fontSize:72,
			fontWeight:'bold'
		}
	});	
	infoView.add(infoLabel);
		
	lineChart.addEventListener('selected',function(e){
		Ti.API.info(JSON.stringify(e));
		if(timerId!=null){
			clearTimeout(timerId);
			timerId = null;
		}		
		dataTypeLabel.text = ((e.dataIndex==0)? 'Local' : 'Nation') + ' Average';
		infoLabel.text = parseFloat(fakeData[e.dataIndex][e.columnIndex]).toFixed(1) + ' ″';			
	});
	
	lineChart.addEventListener('unselected',function(e){
		Ti.API.info(JSON.stringify(e));
		timerId = setTimeout(function(){
			dataTypeLabel.text=''; 
			infoLabel.text='';
		},1000);		
	});	
			
	return win;
};
