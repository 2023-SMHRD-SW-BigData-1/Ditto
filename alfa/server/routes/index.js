const express = require('express')
const app = express();

const router = express.Router()
const dbConfig = require('../config/database');

let conn = dbConfig.init();

dbConfig.connect(conn);

// router.get('/', (req, res) => {
//     res.send({ response: "I am alive" }).status(200)
//   })

router.post('/login', (req, res) => {
    let sql = "SELECT * FROM user_info where user_id = ?"
    console.log("req : " + [req.body.user_id]);

    conn.query(sql, [req.body.user_id], (err, rows) => {
        if (rows[0] !== undefined) {
            if (rows[0].user_id === req.body.user_id) {
                if (rows[0].user_pw === req.body.user_pw) {
                    console.log(rows);
                    res.json({ result: 'success', data: rows })
                } else if (rows[0].user_pw !== req.body.user_pw) {
                    res.json({ result: 'pw err' })
                }
            }
        }
        // 쿼리 결과 처리
        console.log(rows);
        // res.send(rows);
        //     req.session.member = rows
        //     req.session.save(()=>{
        //     res.redirect('/')
        //   });
    });
});



module.exports = router;
