
var chart = require('ti.jbchart'),
	timerId = null,
	months = ['January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'];
        
function randomIntFromInterval(min,max){
    return Math.floor(Math.random()*(max-min+1)+min);
}	
	
exports.createWindow = function(){	
	var fakeData = [],
		colorData =[];
	
	var win = Ti.UI.createWindow({
		backgroundColor:'#404041',barColor:"#000",
		title:"Bar Chart Demo", 
		titleAttributes:  {
	        color:'#fff'
	    },
		layout:'horizontal'
	});
	
	for (var iLoop=0;iLoop<12;iLoop++){
		fakeData.push(randomIntFromInterval(15,110));
		colorData.push((iLoop % 2 == 0) ? 'blue' : 'green');
	}	

	win.add(Ti.UI.createLabel({
		top:0, height:35,width:Ti.UI.FILL,
		text:'Temperature Chart Demo',
		textAlign:'center', color:'#fff',
		font:{
			fontSize:24,
			fontWeight:'bold'
		}		
	}));
	
	var barChart = chart.createBarChartView({
		width:Ti.UI.FILL, height:250, top:10,
		data : fakeData,
		toolTipData : months,
		barColors:colorData,
		selectionBarColor:'yellow',
		chartBackgroundColor:'#404041'
	});
	win.add(barChart);
	
	var infoView = Ti.UI.createView({
		left:50, right:50, top:25, height:150
	});
	win.add(infoView);
	
	var infoLabel = Ti.UI.createLabel({
		height:Ti.UI.FILL, width:Ti.UI.FILL,
		textAlign:'center', color:'#fff',
		font:{
			fontSize:72,
			fontWeight:'bold'
		}
	});	
	infoView.add(infoLabel);
	
	barChart.addEventListener('selected',function(e){		
		Ti.API.info(JSON.stringify(e));	
		if(timerId!=null){
			clearTimeout(timerId);
			timerId = null;
		}			
		infoLabel.text = fakeData[e.columnIndex] + '°F';		
	});
	
	barChart.addEventListener('unselected',function(e){
		Ti.API.info(JSON.stringify(e));
		timerId = setTimeout(function(){
			infoLabel.text='';
		},1000);
	});	
				
	return win;
};
