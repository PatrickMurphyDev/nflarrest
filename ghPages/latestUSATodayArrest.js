/* =========== */
/* Get Latest USA Today Arrest (Node.js / JavaScript Process) */
/* =========== */

const puppeteer = require("puppeteer");

var mysql = require("mysql");
var dbConfig = require("./dbconfig");
var mysql_user_options = dbConfig;
var mysql_result = undefined;

(async () => {

  // Setup Connection 
  var mysql_connection = mysql.createConnection({
    host: mysql_user_options.host,
    user: mysql_user_options.user,
    password: mysql_user_options.password,
    database: mysql_user_options.database,
  });
  // Connect MySQL
  mysql_connection.connect();

  // On Error Report To Console.log
  mysql_connection.on("error", function (err) {
    console.log("[mysql error]", err);
  });

  // Find Most Recent DB Date
  mysql_connection.query(
    "SELECT DATE_FORMAT(Date,'%m/%d/%Y') as DateFormat, Name FROM vwarrestsweb ORDER BY Date DESC, arrest_stats_id DESC LIMIT 1",
    function (error, results, fields) {
      mysql_result = results[0];
    }
  );

  // Launch Scrape Browser
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto("https://databases.usatoday.com/nfl-arrests/");
  await page.setBypassCSP(true);

  // get USA today page result
  const result = await page.$$eval("table tbody tr", (rows) => {
    return Array.from(rows, (row) => {
      const columns = row.querySelectorAll("td");
      return Array.from(columns, (column) => column.innerText);
    });
  });

  // search for match
  var resultFoundBool = false;
  for (var i = 0; i < result.length; i++) {
    if (result[i][0] == mysql_result["DateFormat"]) {
      if (result[i][1] + " " + result[i][2] == mysql_result["Name"]) {
        resultFoundBool = true;
        console.log(
          "Found match, " +
            i +
            " records behind. LatestDB = (" +
            mysql_result["DateFormat"] +
            ", " +
            mysql_result["Name"] +
            ")"
        );
      }
    }
  }

  if (resultFoundBool) {
    mysql_connection.end();
  } else {
    console.log("No Match Found, ahead of USA Today?");
    mysql_connection.end();
  }

  await browser.close();
})();
