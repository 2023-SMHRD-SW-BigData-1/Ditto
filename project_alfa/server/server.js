const express = require('express');
const dbConfig = require('./config/database');
const app = express();
const cors = require('cors');
const http = require('http');

let conn = dbConfig.init();

dbConfig.connect(conn);

// const connection = mysql.createConnection(dbConfig);

// conn.connect((err) => {
//   if (err) {
//     console.error('MySQL 연결 오류: ' + err.stack);
//     return;
//   }
//   console.log('MySQL에 성공적으로 연결되었습니다.');
// });


const server = http.createServer(app)
app.use(cors());


app.use(express.urlencoded({extended:true}));
app.use(express.json());

app.set('port',process.env.PORT || 8889)


// app.use(express.static(path.join(__dirname, '../build')))
// app.get('/', (req, res) =>{
//    res.sendFile(path.join(__dirname, '../build/web/index.html'))
// })

// app.get('/', (req, res) =>{
//     res.json({
//         "id": "testid"
//     });
// })

app.get('/', (req, res) => {
    conn.query('SELECT * FROM user_info', (err, rows) => {
        if (err) {
          console.error('쿼리 오류: ' + err);
          return;
        }
        // 쿼리 결과 처리
        console.log(rows);
        res.send(rows);
      });
  });
  
app.post('/login',(req,res)=>{
  let{id,pw} = req.body

  let sql = 'select user_id,user_pw from user_info where user_id=? and user_pw'
  conn.query(sql,[id,pw],(err,rows,pields)=>{
    print(err)
    req.session.member = rows
    req.session.save(()=>{
      res.redirect('/')
    })
  })
})
  
  

server.listen(app.get('port'),()=>{
    console.log(app.get('port'),'번 포트에서 서버연결 대기중..');
  });
