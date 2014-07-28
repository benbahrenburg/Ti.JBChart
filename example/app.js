// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'#fff',tabBarHidden:true, barColor:"#999", title:"JB Chart Demos"
});

var data =[
	{title:"Line Chart", hasChild:true, itemId:0},
	{title:"Area Chart", hasChild:true, itemId:1}
];

var tableView = Ti.UI.createTableView({
	width:Ti.UI.FILL, height:Ti.UI.FILL, data:data	
});
win.add(tableView);

tableView.addEventListener('click',function(e){
	if(e.rowData.itemId===0){
		tabGroup.activeTab.open(require('line_chart').createWindow());
	}
	if(e.rowData.itemId===1){
		tabGroup.activeTab.open(require('area_chart').createWindow());
	}				
});

var tabGroup = Titanium.UI.createTabGroup();
tabGroup.addTab(Ti.UI.createTab({
	window:win
}));
tabGroup.open();