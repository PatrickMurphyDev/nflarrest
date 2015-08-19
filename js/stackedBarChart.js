var isFirstHover = true;
var stackedBarChart = {
	stackedChart: undefined,
	options: {
		targetElement: '#theElementSelector',
		targetExpandBtn: '#btnSelector',
		showBtn: '#btnSelector',
		hideBtn: '#btnSelector',
		data: {},
		isExpanded: false,
		customLegend: true,
		zoomEnabled: false
	},

	init: function(options){
		$.extend(true, this.options, options);

		var thisChart = this;
		console.log('Initialize Chart:  ' + this.options.targetElement);

		thisChart.options.$targetElement = $(this.options.targetElement);
		thisChart.options.$expandBtnElement = $(this.options.targetExpandBtn);
		thisChart.options.$showBtnElement = $(this.options.showBtn);
		thisChart.options.$hideBtnElement = $(this.options.hideBtn);

		stackedBarChart.options.$expandBtnElement.off('click');
		stackedBarChart.options.$expandBtnElement.click(thisChart.toggleExpand);
		stackedBarChart.options.$hideBtnElement.click(thisChart.hideAllCategories);
		stackedBarChart.options.$showBtnElement.click(thisChart.showAllCategories);

		thisChart.renderChart();
	},

	renderChart: function(){
		if($( document ).width() < 800){
			var bottomPadding = 20;
		}else{
			var bottomPadding = 6;
		}

		stackedBarChart.stackedChart = c3.generate({
        bindto: stackedBarChart.options.targetElement,
        data: {
            x : 'x',
            columns: stackedBarChart.options.data.columns,
            groups: [
                stackedBarChart.options.data.groups
            ],
            type: 'bar',
            onclick: function (d, i) {
                // redirect to
                googleTracking.sendTrackEvent('mainChart','teamLink');
								setTimeout(function(){
				window.location.href = "team.html#"+stackedBarChart.options.data.columns[0][d['index']+1];
								}, 100);
            }
        },
				zoom: {
        	enabled: stackedBarChart.options.zoomEnabled
    		},
			  padding: {
						bottom: bottomPadding
				},
				legend: {
					show: !stackedBarChart.options.customLegend
				},
        axis: {
            x: {
                type: 'category'
            }
        },
			  color: {
					pattern: ['#1F77B4', '#FF7F0E', '#2CA02C', '#D62728', '#9467BD', '#8C564B', '#E377C2', '#7F7F7F', '#BCBD22', '#17BECF', '#154F78', '#B0580A', '#248224', '#7D1717']
				}
    });
		if(stackedBarChart.options.customLegend){
			stackedBarChart.renderCustomLegend();
		}

	},

	renderCustomLegend: function(){
		// should probably try and remove the existing legend first if one exists
		$('.customLegend').remove();
			d3.select('.chart-container').insert('div', '.chart-options').attr('class', 'customLegend').selectAll('span')
			.data(stackedBarChart.options.data.groups)
		.enter().append('span')
			.attr('data-id', function (id) { return id; })
			.attr('class', function (id) {
				var newID = id.replace('/', '');
				newID = newID.split(' ').join('');
				return 'customLegend-item customLegend-item-' + newID; })
			.html(function (id) { return "<span class=\"customLegend-item-color\" style=\"background-color:"+ stackedBarChart.stackedChart.color(id) +";\"></span> " + id; })
			.on('mouseover', function (id) {
					if()
					stackedBarChart.stackedChart.focus(id);
					if(isFirstHover){
						isFirstHover = false;
						googleTracking.sendTrackEvent('mainChart', 'legendMouseover');
					}
			})
			.on('mouseout', function (id) {
					stackedBarChart.stackedChart.revert();
			})
			.on('click', function (id) {
					stackedBarChart.stackedChart.toggle(id);
					var newID = id.replace('/', '');
					newID = newID.split(' ').join('');
					var legendItem = d3.select('.customLegend-item-'+newID);
					legendItem.classed("transparent", !legendItem.classed("transparent"));
					googleTracking.sendTrackEvent('mainChart', 'legendClick');
			});
	},

	toggleExpand: function(){
		// toggle sizing
		stackedBarChart.options.$targetElement.toggleClass('expanded');

		// toggle button state
		stackedBarChart.options.isExpanded = !stackedBarChart.options.isExpanded;

		// toggle button text
		if(stackedBarChart.options.isExpanded){
				stackedBarChart.options.$expandBtnElement.html('Collapse');
		}else{
				stackedBarChart.options.$expandBtnElement.html('Expand');
		}

		googleTracking.sendTrackEvent('mainChart', 'expand toggle');
		// re-render
		stackedBarChart.renderChart();
	},
	hideAllCategories: function(){
		googleTracking.sendTrackEvent('mainChart', 'hide all categories');
		stackedBarChart.stackedChart.hide();
		$('.customLegend-item').addClass('transparent');
	},
	showAllCategories: function(){
		googleTracking.sendTrackEvent('mainChart', 'show all categories');
		stackedBarChart.stackedChart.show();
		$('.customLegend-item').removeClass('transparent');
	}
};
