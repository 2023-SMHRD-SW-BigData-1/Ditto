const mysql = require('mysql2');

const dbConfig = {
    host     : 'project-db-campus.smhrd.com',
    user     : 'ditto',
    password : 'ditto',
    database : 'ditto',
    port : 3307,
    timezone : '+00:00',
};

module.exports = {
    init : function(){
        return mysql.createConnection(dbConfig)
    },
    connect : function(conn){
        conn.connect(function(err){
            if(err) console.log('DB 연결 실패', err);
            else console.log('DB 연결 성공!');
        })
    }
}
