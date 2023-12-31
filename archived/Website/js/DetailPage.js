class DetailPage {
	constructor(pageID, pageTitle, chartOptions, arrestsUrl) {
		this.pageID = pageID; // SEA
		this.pageTitle = pageTitle; // Team
		this.arrestsUrl = arrestsUrl; // api/team/arrests.php?id=
		this.chartOptions = chartOptions; // [{url:'',field:'',targetElement:'',title:''}]
		this.arrest_view_mode = 0; // 0 = table, 1 = card (Mobile Default)
		this.data_controller;

		this.callbackReturns = 0;
		this.charts = [];

		var self = this;

		if (mobileCheck())
			this.arrest_view_mode = 1; // if mobile use cards

		$('body').append('<div id="loading-bar">Loading...</div>');
		$('#loading-bar').fadeIn();
		$(window).on('hashchange', function () {
			self.renderView()
		});

		dateRangeController.init(function (newDateRange) {
			self.dateRangeNFL = newDateRange;
			DataController.init(self.dateRangeNFL, function (newDataController) {
				self.data_controller = newDataController;
				var page_dimension = self.pageTitle.toLowerCase();
				var filters_options = {
					presets: {},
					date_range_object: self.dateRangeNFL
				};

				filters_options['presets'][page_dimension] = {};
				filters_options['presets'][page_dimension][page_dimension] = self.pageID;
				self.FilterControl = new FiltersControl(filters_options);
				$(self.FilterControl.options.dialog_element).on('FilterDialogChanged', function () {
					console.log('render view filter');
					// todo not working, using the hash change global for now
					self.renderView();
				});

				$('#dateRangeJquery').on('dateRangeChanged', function (e) {
					self.renderView();
				});

				/*
			$('#dateRangeJquery').on('dateRangeChanged', function (e) {
				nflLoadingBar.showLoading();
				setupChart();
				reload_top_lists();
			});
				*/

				self.renderView();
			})
		});
	}

	getLink(Dimension, EntityValue){
		return Dimension + '.html#' + EntityValue;
	}

	getCrimeLink(EntityValue){
		return this.getLink('Crime', EntityValue);
	}

	getPlayerLink(EntityValue){
		return this.getLink('Player', EntityValue);
	}

	getTeamLink(EntityValue){
		return this.getLink('Team', EntityValue);
	}

	getPositionLink(EntityValue){
		return this.getLink('Position', EntityValue);
	}

	changeTitle(newTitle, s) {
		var self = s || this;
		document.title = "NFL Arrest | " + newTitle + " | List of Player Arrests";
		$('#pageTitle').html(self.pageTitle + ": " + newTitle);
	}

	renderView() {
		$('#loading-bar').fadeIn();
		this.pageID = update_hash(this.pageID);
		this.changeTitle();
		this.setupCharts();
		this.renderArrests();
	}

	checkLoadingFinished() {
		if (++this.callbackReturns == (1 + this.chartOptions.length)) { // 1 for arrests plus each chart
			this.callbackReturns = 0;
			$('#loading-bar').fadeOut();
			setupFacebook();
			setupTwitter();
		}
	}

	renderArrests() {
		var self = this;
		self.data_controller.getArrests(function(row){
				if(self.pageTitle == 'Team'){
					if(row['Team'] != self.pageID){
						return false;
					}
				}else if(self.pageTitle == 'Position'){
					if(row['Position'] != self.pageID){
						return false;
					}
				}else if(self.pageTitle == 'Player'){
					if(row['Name'] != self.pageID){
						return false;
					}
				}else if(self.pageTitle == 'Crime'){
					if(row['Category'] != self.pageID){
						return false;
					}
				}
				return true;
			}, function (data) {
				var row,
					items = [];

				$('body > div.container > section > div > h4').html(data.length + ' Incidents:');
				if (self.arrest_view_mode == 0) {
					items.push(self.renderArrestRowHeader());
				}

				for (var rowID in data) {
					row = data[rowID];
					if (self.arrest_view_mode == 0) {
						items.push(self.renderArrestRow(row));
					} else if (self.arrest_view_mode == 1) {
						items.push(self.renderArrestCard(row));
					}
				}

				$('#arrest_table').html(items.join(""));
				self.checkLoadingFinished();
		});
	}

	// should be overloaded
	renderArrestRowHeader() {
		var return_text = '<tr>';
		return_text += '<th class="one column">Date:</th>';
		return_text += '<th class="one column">Team:</th>';
		return_text += '<th class="two columns">Name:</th>';
		return_text += '<th class="one column">Crime:</th>';
		return_text += '<th class="four columns">Description:</th>';
		return_text += '<th class="three columns">Outcome:</th>';
		return_text += '</tr>';

		return return_text;
	}


	// should be overloaded
	renderArrestRow(row) {
		var return_text = '<tr>';
		return_text += '<td class="one column">' + moment(row['Date'], "YYYY-MM-DD").fromNow() + '</td>';
		return_text += '<td class="one column">' + row['Team'] + '</td>';
		return_text += '<td class="two columns"><a href="PlayerCache.html#' + row['Name'] + '">' + row['Name'] + '</a></td>';
		return_text += '<td class="one column"><a href="CrimeCache.html#' + row['Category'] + '">' + row['Category'] + '</a></td>';
		return_text += '<td class="four columns">' + row['Description'] + '</td>';
		return_text += '<td class="three columns">' + row['Outcome'] + '</td>';
		return_text += '</tr>';

		return return_text;
	}

	renderArrestCard(row) {
		var card = ['<div class="card arrest_card">'];
		card.push('<span class="date_item" title="' + row['Date'] + '">' + moment(row['Date'], "YYYY-MM-DD").fromNow() + '</span>');
		card.push('<span class="name_item">' + row['Name'] + '</span>');
		card.push("<br />");
		card.push('<span class="crime_item" style="background-color:#' + row['Crime_category_color'] + '">');
			card.push('<a href="CrimeCache.html#' + row['Category'] + '">' + row['Category'] + "</a> </span>");
		card.push('<span class="team_item ' + row['Team'] + '" style="background-color:#' + row['Team_hex_color'] + ';">');
			card.push('<a href="TeamCache.html#' + row['Team'] + '" style="color:#' + row['Team_hex_alt_color'] + ';" >' + row['Team_preffered_name'] + '</a></span>');
		card.push('<br />');
		card.push('<span class="description_item">' + row['Description'] + '</span>'); // .substring(0,n)
		card.push('<span class="outcome_item">' + row['Outcome'] + '</span>');
		card.push('</div>');
		var card2 = card.join('');
		//console.log(card2);
		return card2;
	}

	getDonutData(url, param, chartID, callback) {
		var self = this;

		var filterFunction = function (row) {
				if(self.pageTitle == 'Team'){
					if(row['Team'] != self.pageID){
						return false;
					}
				}else if(self.pageTitle == 'Position'){
					if(row['Position'] != self.pageID){
						return false;
					}
				}else if(self.pageTitle == 'Player'){
					if(row['Name'] != self.pageID){
						return false;
					}
				}else if(self.pageTitle == 'Crime'){
					if(row['Category'] != self.pageID){
						return false;
					}
				}

				return true;
			};

		var callbackFunc = function (data) {
				var theData = [];
				var index, i = 0;
				var otherArray = ['Other', 0];
				for (index in data) {
					if (++i < 12) {
						theData.push([data[index][param], data[index]['arrest_count']]);
					} else {
						otherArray[1] = parseInt(otherArray[1]) + parseInt(data[index]['arrest_count']);
					}
				}
				theData.push(otherArray);
				self.checkLoadingFinished();
				callback(theData, chartID);
			};			

		self.data_controller.getDonutChart(param, filterFunction, callbackFunc);
	}

	setupCharts() {
		var self = this;
		for (var chartID in self.chartOptions) {
			var chartOption = self.chartOptions[chartID];
			self.getDonutData(chartOption.url + self.pageID, chartOption.field, chartID, function (newData, cID) {
				self.charts.push(new DonutChart({
					data: newData,
					targetElement: self.chartOptions[cID].targetElement,
					chartTitle: self.chartOptions[cID].title
				}));
			});
		}
	}

}
