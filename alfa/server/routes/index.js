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

router.post('/join/create', (req, res) => {
    let sql2 = "select user_id from user_info where user_id = ?";
    conn.query(sql2, [req.body.user_id], (err, rows) => {
        console.log(rows, req.body.user_id);
        if (rows[0] == undefined) {
            let sql = "insert into user_info values(?, ?, '1', ?, ?, now(), null)";
            console.log("req : " + [req.body.user_id]);
            console.log("req : " + [req.body.user_pw]);
            console.log("req : " + [req.body.user_name]);
            console.log("req : " + [req.body.user_num]);

            conn.query(sql, [req.body.user_id, req.body.user_pw, req.body.user_name, req.body.user_num], (err, rows) => {
                console.log('insert : ' + rows);
                if (rows != undefined) {
                    // if (rows[0].user_id === req.body.user_id) {
                    //     if (rows[0].user_pw === req.body.user_pw) {
                    console.log('success');
                    res.json({ result: 'success' })
                    // } else if (rows[0].user_pw !== req.body.user_pw) {
                        // res.json({ result: 'pw err' })
                } else {
                    res.json({ result: 'failed' })
                }
            }
            )
        } else {
            console.log('id existed');
            res.json({ result: 'failed' })

        }
    })

});
// });

module.exports = router;
