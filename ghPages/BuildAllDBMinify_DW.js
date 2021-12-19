// --- Include Refrenced Packages --- //
var fs = require('fs');
var UglifyJS = require("uglify-js");
var mysql = require('mysql');
var node_minify = require('node-minify');
var gits = require('simple-git');
var readline = require('readline');
var mysqldump = require('mysqldump');
var dbConfig = require('./dbconfig');
var readline = readline.createInterface(process.stdin, process.stdout);
var shell = require('shelljs');

function runNode(path, cb1, cb){
	shell.exec('node '+ path, function(code, stdout, stderr){
		cb(code, stdout, stderr, cb1);
	});
}

function nodeCB(code, stdout, stderr, cb) {
	if(code !== 0){
		console.log('Program stderr:', stderr);
		shell.exit(1);
	}else{	
        //console.log('Prod Dev File Diff: ',stdout);
		cb();
	}
}

var git = gits('./nflarrest/');

// --- Script Arguments --- //
var runOption_Environment_enum = ["development", "production"];
var runOption_Environment = 0;
var runOption_Generate_CSS_Flag = true;
var runOption_Generate_JS_Flag = true;
var runOption_UseModular_CSS_Flag = true;
var runOption_publish = false;
var runOption_publish_AllFiles = false;


var runOption_Environments = [{
    Environment: "development",
    path: "/development/"
}, {
    Environment: "production",
    path: "/"
}];

// --- Script Parameters --- //
var mysql_user_options = dbConfig;

var path_global = "nflarrest";

var MinFilename_JS = 'index.min.js';
var MinFilename_Detail_JS = 'DetailPage.min.js';
var MinFilename_CSS = "styles.min.css";
var DataFilename_JSON = 'ArrestsCacheTable_data.js';
var DataFilePath = 'js/data/';

var DW_stored_procedures = ["sp_dim_day_update", "sp_etl_arrests", "sp_materialize_arrests"];
var DW_arrests_view = "vwarrestsweb";
var mysqldump_path = '../Database/backup/lastGHPagesUpdateDump.sql';

var JS_filenames = ['js/nflLoadingBar.js',
    //'js/data/ArrestsCacheTable_data.js',
    'js/modules/ArrestCard.Module.js',
    'js/data/lastUpdate_data.js',
    'js/DataController.js',
    'js/index_no_php.js',
    'js/common.js',
    'js/charts/stackedBarChart.js',
    'js/dateRangeController.js',
    'js/google-tracking.js',
    'js/loadCSS.js'
];

var JS_filenames_detail = [
    'js/DetailPage.js',
    'js/model/FiltersModel.js',
    'js/FiltersControl.js',
    'js/charts/donutChart.js',
    'js/data/lastUpdate_data.js',
    'js/modules/ArrestCard.Module.js',
    'js/DataController.js',
    'js/common.js',
    'js/charts/timeSeriesChart.js',
    'js/dateRangeController.js',
    'js/google-tracking.js',
    'js/loadCSS.js'
];

var CSS_filenames = ['css/styles-modular.css',
    'css/modules/styles-indexpage.css',
    'css/modules/styles-daterange.css',
    'css/modules/styles-toplists.css',
    'css/modules/styles-arrestometer.css',
    'css/modules/styles-chart.css',
    'css/modules/styles-cards.css',
    'css/modules/styles-kpi.css',
    'css/modules/styles-mobile.css'
];

function getEnvPath(path) {
    return path_global + runOption_Environments[runOption_Environment].path + path;
}


function getJSFiles() {
    var jsFiles = [];
    for (var i = 0; i < JS_filenames.length; i++) {
        jsFiles.push(getEnvPath(JS_filenames[i]));
    }
    return jsFiles;
}

function getJSFilesDetail() {
    var jsFiles2 = [];
    for (var i = 0; i < JS_filenames_detail.length; i++) {
        jsFiles2.push(getEnvPath(JS_filenames_detail[i]));
    }
    return jsFiles2;
}

function getCSSFiles() {
    var cssFiles = [];
    for (var i = 0; i < CSS_filenames.length; i++) {
        cssFiles.push(getEnvPath(CSS_filenames[i]));
    }
    return cssFiles;
}

// use stored_procedures array for sp
function call_sp(sp, mysql, callback) {
    mysql.query("CALL " + sp + "()", function(error2, results2, fields2) {
        if (error2) {
            console.log(error2);
        }
        console.log("Success::     " + sp + "() Proc::  Rows Affected: " + results2.affectedRows);
        callback();
    });
}

function cacheArrestsDateViewJS(mysql, callback) {
    var SelectQuery = "SELECT * FROM " + DW_arrests_view;

    mysql.query(SelectQuery, function(error, results, fields) {
        var newText = "var ArrestsCacheTable = " + JSON.stringify(results) + ";";

        fs.writeFile(getEnvPath(DataFilePath + DataFilename_JSON), newText, function(err) {
            if (err) {
                return console.log("Error:: " + err);
            }
            console.log("Success::     JS Data Table " + DataFilename_JSON + " saved.");
            callback();
        });
    });
}

function cacheUpdateDate(callback) {
    var datecurr = new Date();
    var newText = "var lastUpdate = \"" + datecurr.toLocaleString("en-US") + "\";";

    fs.writeFile(getEnvPath(DataFilePath + "lastUpdate_data.js"), newText, function(err) {
        if (err) {
            return console.log("Error:: " + err);
        }
        console.log("Success::     JS Data Table " + "lastUpdate_data.js" + " saved.");
        callback();
    });
}

function minifyHomepage(callback) {
    minifyJS(function() {
        minifyCSS(function() {
            callback();
        });
    });
}

function minifyJS(callback) {
    // Using UglifyJS
    if (runOption_Generate_JS_Flag) {
        var files1 = getJSFiles();
        var files2 = getJSFilesDetail();
        
        var fileObj1 = {};
        var fileObj2 = {};
        
        for(var i = 0; i < files1.length; i++){
            var key = files1[i].slice(files1[i].lastIndexOf('/')+1,files1[i].length);
            fileObj1[key] = fs.readFileSync(files1[i], "utf8");
        }
        
        for(var j = 0; j < files2.length; j++){
            var key = files2[j].slice(files2[j].lastIndexOf('/')+1,files2[j].length);
            fileObj2[key] = fs.readFileSync(files2[j], "utf8");
        }
        
        fs.writeFileSync(getEnvPath('js/compressed/'+ MinFilename_JS), UglifyJS.minify(fileObj1).code);
        console.log('Success::     Minify Homepage JS: ' + MinFilename_JS);
        fs.writeFileSync(getEnvPath('js/compressed/'+ MinFilename_Detail_JS), UglifyJS.minify(fileObj2).code);
        console.log('Success::     Minify Homepage JS Detail Page: ' + MinFilename_Detail_JS);
        
        callback();
    }
}

function minifyCSS(callback) {
    if (runOption_Generate_CSS_Flag) {
        // minify CSS modular or not
        if (runOption_UseModular_CSS_Flag) {
            // generate css from modular files
            node_minify.minify({
                compressor: 'clean-css',
                input: getCSSFiles(),
                output: getEnvPath('css/' + MinFilename_CSS),
                callback: function(err, min) {
                    console.log('Success::     CSS Minify finished Modular: ' + MinFilename_CSS);
                    callback();
                }
            });
        } else {
            // minify CSS non modular
            node_minify.minify({
                compressor: 'clean-css',
                input: [getEnvPath('css/styles.css')],
                output: getEnvPath('css/' + MinFilename_CSS),
                callback: function(err, min) {
                    console.log('Success::     CSS Minify finished non modular: ' + MinFilename_CSS);
                    callback();
                }
            });
        }
    }
}


function dumpDatabase(callback) {
    console.log('MYSQL:     DUMP SQL');
    mysqldump({
        connection: {
            host: mysql_user_options.host,
            user: mysql_user_options.user,
            password: mysql_user_options.password,
            database: mysql_user_options.database,
        },
        dumpToFile: mysqldump_path,
    });

    callback();
}

function main() {
    console.log("ENVIRONMENT:  " + runOption_Environments[runOption_Environment].Environment);

    var mysql_connection = mysql.createConnection({
        host: '127.0.0.1',
        user: 'root',
        password: 'BinaryStar2021!',
        database: 'nflarrestdw'
    });
    mysql_connection.connect();
    console.log("MYSQL:        Connected");

    mysql_connection.on('error', function(err) {
        console.log("[mysql error]", err);
    });

    call_sp("sp_day_dim_update", mysql_connection, function() {
        call_sp("sp_etl_arrests", mysql_connection, function() {
            call_sp("sp_materialize_arrests", mysql_connection, function() {
                cacheArrestsDateViewJS(mysql_connection, function() {
                    cacheUpdateDate(function() {
                        minifyHomepage(function() {
                            dumpDatabase(function() {
                                runNode("BuildFileDiff.js", function(){
                                    // determine if process should publish ghpages changes
                                    checkPublish();
                                }, nodeCB);
                            });
                        });
                    });
                    mysql_connection.end();
                });
            });
        });
    });
}


function checkPublish() {
    if (runOption_publish) {
        promptConfirmPublish();
    } else {
        console.log("GIT:          Not Publishing (tip: add arg 'publish' to publish)");
        readline.close();
    }
}

async function promptConfirmPublish() {
    var StatusResult = await git.status();
    console.log(StatusResult.files);
    var allFiles = runOption_publish_AllFiles ? ' ~~!!WARNING ALL FILES SET!!~~ ' : '';
    
    readline.question("GIT:          Publish changes? " + allFiles + " [yes]/no: ", function(answer) {
        if (answer === "no") {
            console.log("GIT:          Not Publishing");
            readline.close();
        } else {
            console.log("GIT:          Publishing...");
            publishGHPages();
        }
    });
}

function publishGHPages() {
    //Git add ., Git commit -m "update x", git push;
    if (runOption_publish_AllFiles) {
        var addAllPath = '.';
        if (runOption_Environment == runOption_Environment_enum.indexOf("development")) {
            addAllPath += runOption_Environments[runOption_Environment].path;
        }
        git.add(addAllPath, function(p1, p2, p3) {
            console.log('GIT File Add: all changes');
            var datenow = new Date();
            var msg = "AUTO COMMIT: " + (datenow.toLocaleDateString('en-US')) + " Build Process " + datenow.getHours() + ":" + datenow.getMinutes();
            git.commit(msg, function() {
                git.push();
                readline.close();
            });
        });
    } else {
        git.add('.' + runOption_Environments[runOption_Environment].path + 'js/data/ArrestsCacheTable_data.js', function(p1, p2, p3) {
            git.add('.' + runOption_Environments[runOption_Environment].path + 'js/compressed/index.min.js', function(p1, p2, p3) {
                git.add('.' + runOption_Environments[runOption_Environment].path + 'css/styles.min.css', function(p1, p2, p3) {
                    git.add('.' + runOption_Environments[runOption_Environment].path + 'js/data/lastUpdate_data.js', function(p1, p2, p3) {
                        console.log('GIT File Add: ArrestsCacheTable_data.js, index.min.js, and styles.min.css, lastUpdate_data.js');
                        var datenow = new Date();
                        var msg = "AUTO COMMIT: " + (datenow.toLocaleDateString('en-US')) + " Build Process " + datenow.getHours() + ":" + datenow.getMinutes();
                        git.commit(msg, function() {
                            git.push();
                            gitCheckoutBranch();
                            readline.close();
                        });
                    });
                });
            });
        });
    }
}

function gitCheckoutBranch(b) {
    b = b || "gh-pages";
    git.checkout(b);
}

// Handle Script arguments
process.argv.forEach(function(val, index, array) {
    // Environment: development, production
    // Minify Options: only-js, only-css
    // Use Modular CSS: modular-css
    if (val === "allfiles") {
        runOption_publish_AllFiles = true;
    }

    if (val === "development") {
        runOption_Environment = runOption_Environment_enum.indexOf("development");
    }
    if (val === "production") {
        runOption_Environment = runOption_Environment_enum.indexOf("production");
    }

    if (val === "publish") {
        runOption_publish = true;
    }

    if (val === "only-js") {
        runOption_Generate_CSS_Flag = false;
        runOption_Generate_JS_Flag = true;
    }
    if (val === "only-css") {
        runOption_Generate_JS_Flag = false;
        runOption_Generate_CSS_Flag = true;
    }
    if (val === "modular-css") {
        runOption_Generate_CSS_Flag = true;
        runOption_UseModular_CSS_Flag = true;
    }
});
main();