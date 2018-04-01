var compressor = require('node-minify');

var filename = 'compressed_homepage.js';
var cssFilename = "styles.min.css";

var generateCSS = true;
var generateJS = true;
var modular_css = false;

process.argv.forEach(function (val, index, array) {
	if (val === "test") {
		filename = 'compressed_homepage_test.js';
		cssFilename = "styles.min.test.css";
	}
	if (val === "only-js") {
		generateCSS = false;
		generateJS = true;
	}
	if (val === "only-css") {
		generateJS = false;
		generateCSS = true;
	}
	if (val === "test-js") {
		filename = 'compressed_homepage_test.js';
	}
	if (val === "modular-css") {
		generateCSS = true;
		modular_css = true;
		//cssFilename = "styles-modular.min.css";
	}
});

// Using UglifyJS
if (generateJS) {
	compressor.minify({
		compressor: 'uglifyjs',
		input: ['../js/index.js', '../js/common.js', '../js/stackedBarChart.js', '../js/dateRangeController.js', '../js/google-tracking.js', '../js/nflLoadingBar.js', '../js/loadCSS.js'],
		output: '../js/' + filename,
		callback: function (err, min) {
			console.log('finished: ' + filename);
		}
	});
}

if (generateCSS) {
	if (modular_css) {
		// generate css from modular files
		compressor.minify({
			compressor: 'clean-css',
			input: ['../css/styles-modular.css',
                    '../css/modules/styles-indexpage.css',
                    '../css/modules/styles-daterange.css',
                    '../css/modules/styles-toplists.css',
                    '../css/modules/styles-arrestometer.css',
                    '../css/modules/styles-chart.css',
                    '../css/modules/styles-cards.css',
                    '../css/modules/styles-kpi.css',
					'../css/modules/styles-mobile.css'
                   ],
			output: '../css/' + cssFilename,
			callback: function (err, min) {
				console.log('css finished: ' + cssFilename);
			}
		});
	} else {
		compressor.minify({
			compressor: 'clean-css',
			input: ['../css/styles.css'],
			output: '../css/' + cssFilename,
			callback: function (err, min) {
				console.log('css finished: ' + cssFilename);
			}
		});
	}
}
