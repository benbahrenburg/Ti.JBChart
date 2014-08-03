
var chart = require('ti.jbchart'),
	timerId = null,
	months = ['January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'];
        
function getRandomData(){
	var results =[],
		fakeLimit = 12;
				
	function createRandom(min,max){
	    return Math.random() * (max - min) + min;
	}	
	for (var iLoop=0;iLoop<fakeLimit;iLoop++){
		results.push(createRandom(1,24));
	}	
	return results;
};
	
exports.createWindow = function(){	
	var fakeData = [];
	
	var win = Ti.UI.createWindow({
		backgroundColor:'#404041',barColor:"#000",
		title:"Area Chart Demo", 
		titleAttributes:  {
	        color:'#fff'
	    },
		layout:'horizontal'
	});
			
	fakeData.push(getRandomData());
	fakeData.push(getRandomData());
	
	win.add(Ti.UI.createLabel({
		top:0, height:35,width:Ti.UI.FILL,
		text:'Sun vs Moon Hours Demo',
		textAlign:'center', color:'#fff',
		font:{
			fontSize:24,
			fontWeight:'bold'
		}		
	}));
			
	var areaChart = chart.createAreaChartView({
		width:Ti.UI.FILL, height:250, top:10,
		data : fakeData,
		toolTipData : months,
		selectedLineColors :['yellow','orange'],
		selectedFillColors :['yellow','orange'],
		fillColors:['green','blue'],
		lineColors:['purple','red'],
		styles :[chart.CHART_AREA_SMOOTH,chart.CHART_AREA_SOLID],
		selectionBarColor:'#fff',
		chartBackgroundColor:'#404041'
	});
	win.add(areaChart);

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
		
	areaChart.addEventListener('selected',function(e){
		Ti.API.info(JSON.stringify(e));		
		if(timerId!=null){
			clearTimeout(timerId);
			timerId = null;
		}
		dataTypeLabel.text = (e.dataIndex==0)? 'Sun' : 'Moon';
		infoLabel.text = parseFloat(fakeData[e.dataIndex][e.columnIndex]).toFixed(1) + ' Hrs';			
	});
	
	areaChart.addEventListener('unselected',function(e){
		Ti.API.info(JSON.stringify(e));
		timerId = setTimeout(function(){
			dataTypeLabel.text=''; 
			infoLabel.text='';
		},1000);		
	});	
			
	return win;
};

