
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
		titleAttributes:  {
	        color:'#fff'
	    },
		layout:'horizontal'
	});
		
	
	fakeData.push(getRandomData());
	fakeData.push(getRandomData());
	
	win.add(Ti.UI.createLabel({
		top:0, height:35,width:Ti.UI.FILL,
		text:'Rainfall Average Demo',
		textAlign:'center', color:'#fff',
		font:{
			fontSize:24,
			fontWeight:'bold'
		}		
	}));
			
	var lineChart = chart.createLineChartView({
		width:Ti.UI.FILL, height:250, top:50,
		data : fakeData,
		toolTipData : weekdays,
		lineStyles :[chart.CHART_LINE_SOLID,chart.CHART_LINE_DASHED],
		selectedLineColor :['yellow','orange'],
		lineColor:['green','blue'],
		selectionBarColor:'#fff',
		chartBackgroundColor:'#404041'
	});
	win.add(lineChart);

	var infoView = Ti.UI.createView({
		left:10, right:10, top:25, height:150
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
