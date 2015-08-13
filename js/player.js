var dateRangeNFL,
		charts = [],
		pageID = undefined;

$( document ).ready(function() {
	update_hash();
	$(window).on('hashchange', function() {
		update_hash();
		setupCharts();
		renderArrests();
	});


	dateRangeController.init(function(newDateRange){
		dateRangeNFL = newDateRange;
		setupCharts();
		renderArrests();
		console.log('init');
		$('.dateRangeEditor').on('dateRangeChanged', function (e){
			console.log('event caught');
			setupCharts();
			renderArrests();
		});
	});
});

function update_hash(){
	pageID = window.location.hash || '#ID Not Set';
	pageID = pageID.replace('#', '');
	$('#pageTitle').append(pageID);
}

function getDonutData(url, param, callback){
	$.getJSON(url+'&start_date='+dateRangeNFL.getStart()+'&end_date='+dateRangeNFL.getEnd(), function(data){
		var theData = [];
		var index, i = 0;
		for(index in data){
				theData.push([data[index][param], data[index]['arrest_count']]);
		}
		callback(theData);
	});
}

function setupCharts(){
	getDonutData('api/player/topCrimes.php?id=' + pageID, 'category', function(newData){
		var newChart = donutChart.init({
			data: newData,
			targetElement: '#crimeschart',
			chartTitle: 'Top Crimes'
		});
 		charts.push(newChart);
  });
}

function renderArrests(){
	$.getJSON('api/player/arrests.php?id=' + pageID +'&start_date='+dateRangeNFL.getStart()+'&end_date='+dateRangeNFL.getEnd(), function(data){
		var row,
				items = ['<tr><th class="one column">Date:</th><th class="two columns">Name:</th><th class="one column">Crime:</th><th class="one column">Team:</th><th class="four columns">Description:</th><th class="three columns">Outcome:</th></tr>'];
		for(row in data){
			row = data[row];
				items.push('<tr><td class="one column">'+moment(row['Date'], "YYYY-MM-DD").fromNow() +'</td><td class="two columns">'+row['Name']+'</td><td class="one columns">'+row['Category']+'</td><td class="one column">'+row['Team']+'</td><td class="four columns">'+row['Description']+'</td><td class="three columns">'+row['Outcome']+'</td></tr>');
		}
		$('#arrest_table').html(items.join(""));
	});
}