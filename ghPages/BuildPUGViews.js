var pug = require('pug');
var fs = require('fs');

class BuildPUGViews {
    constructor(filePath, getEnvPathFn){
        this.filePath = filePath || 'views/';
        this.getEnvPathFn = getEnvPathFn || function(str){return str};
        this.loadPUGTemplates();
    }
    
    loadPUGTemplates() {
        this.PUG_fn_generateDetailPageCrime = pug.compileFile(this.getEnvPathFn(this.filePath + 'Crime.pug'));
        this.PUG_fn_generateDetailPageCrimeCategory = pug.compileFile(this.getEnvPathFn(this.filePath + 'CrimeCategory.pug'));
        this.PUG_fn_generateDetailPagePlayer = pug.compileFile(this.getEnvPathFn(this.filePath + 'Player.pug'));
        this.PUG_fn_generateDetailPageTeam = pug.compileFile(this.getEnvPathFn(this.filePath + 'Team.pug'));
        this.PUG_fn_generateDetailPagePosition = pug.compileFile(this.getEnvPathFn(this.filePath + 'Position.pug'));
        this.PUG_fn_generateIndexPage = pug.compileFile(this.getEnvPathFn(this.filePath + 'index.pug'));
        this.PUG_fn_generateMethodologyPage = pug.compileFile(this.getEnvPathFn(this.filePath + 'Methodology.pug'));
    }

    exportPUGViews() {
        var pageData = {
            pageTitle: 'Crime',
            pageDesc: "The page where you can read about crimes."
        };
        fs.writeFile(this.getEnvPathFn('Crime.html'), this.PUG_fn_generateDetailPageCrime(pageData), function (err) {
            if (err) {
                return console.log("Error:: " + err);
            }
            console.log("Success::       PUG Crime Output saved.");
        });
        var pageData = {
            pageTitle: 'Crime Category',
            pageDesc: "The page where you can read about crimes."
        };
        fs.writeFile(this.getEnvPathFn('CrimeCategory.html'), this.PUG_fn_generateDetailPageCrimeCategory(pageData), function (err) {
            if (err) {
                return console.log("Error:: " + err);
            }
            console.log("Success::       PUG CrimeCategory Output saved.");
        });
        pageData = {
            pageTitle: 'Player',
            pageDesc: "The page where you can read about crimes by each NFL Player arrested."
        };
        fs.writeFile(this.getEnvPathFn('Player.html'), this.PUG_fn_generateDetailPagePlayer(pageData), function (err) {
            if (err) {
                return console.log("Error:: " + err);
            }
            console.log("Success::       PUG Player Output saved.");
        });
        pageData = {
            pageTitle: 'Team',
            pageDesc: "The page where you can read about NFL Arrests by team."
        };
        fs.writeFile(this.getEnvPathFn('Team.html'), this.PUG_fn_generateDetailPageTeam(pageData), function (err) {
            if (err) {
                return console.log("Error:: " + err);
            }
            console.log("Success::       PUG Team Output saved.");
        });
        pageData = {
            pageTitle: 'Position',
            pageDesc: "The page where you can read about NFL crimes by position."
        };
        fs.writeFile(this.getEnvPathFn('Position.html'), this.PUG_fn_generateDetailPagePosition(pageData), function (err) {
            if (err) {
                return console.log("Error:: " + err);
            }
            console.log("Success::       PUG Position Output saved.");
        });
        pageData = {pageTitle: 'index',
            pageDesc: "NFL Arrest.com Home Page"};
        fs.writeFile(this.getEnvPathFn('index.html'), this.PUG_fn_generateIndexPage(pageData), function (err) {
            if (err) {
                return console.log("Error:: " + err);
            }
            console.log("Success::       PUG index.html Output saved.");
        });
        
        pageData = {pageTitle: 'Methodology',
            pageDesc: "NFLArrest Dataset Description"};
        fs.writeFile(this.getEnvPathFn('Methodology.html'), this.PUG_fn_generateMethodologyPage(pageData), function (err) {
            if (err) {
                return console.log("Error:: " + err);
            }
            console.log("Success::       PUG Methodology.html Output saved.");
        });
    }
}

module.exports = BuildPUGViews;