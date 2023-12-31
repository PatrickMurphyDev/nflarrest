var mysql = require('mysql');

module.exports = class MYSQLController {
    constructor(s){
        // supplied settings or defaults
        this.settings = s || {
            host: '192.185.35.74',
            user: 'pmphotog_nfl',
            password: '12thman',
            database: 'pmphotog_nfl'
        };
        this.mysql_connection = this.connectSQL();
    }

    // connect to SQL function
    connectSQL(){
        console.log('MYSQL Connected: ' + this.settings.database);
        return mysql.createConnection(this.settings);
    }

    disconnectSQL() {
        this.mysql_connection.end();
        console.log('MYSQL Disconnected');
    }

    query(query,data,callback){
        console.log('MYSQL Debug: Query: ' + query + " Data: " + JSON.stringify(data));
        // if data is set, and not null/false then use it, else callback
        if(data)
            this.mysql_connection.query(query,data,callback)
        else
            this.mysql_connection.query(query,callback);
    }

    // select
    select(query,callback){
        this.query(query,false,callback);
    }

    // insert
    insert(query,data,callback){
        return this.query(query,obj,data,callback);
    }
};