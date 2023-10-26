const express = require('express')
const app = express();

const router = express.Router()
const dbConfig = require('../config/database');

let conn = dbConfig.init();

dbConfig.connect(conn);

// router.get('/', (req, res) => {
//     res.send({ response: "I am alive" }).status(200)
//   })

router.post('/user/login', (req, res) => {
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
        } else {
            res.json({ result: 'empty id' })
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

router.post('/user/create', (req, res) => {
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

router.post('/user/modify', (req, res) => {
    let sql = "update user_info set user_pw = ?, user_num = ? where user_id = ?;"
    console.log("req : " + [req.body.user_id]);

    conn.query(sql, [req.body.user_pw, req.body.user_num, req.body.user_id], (err, rows) => {
        if (rows != undefined) {
            let sql2 = "select * from user_info where user_id = ?";
            conn.query(sql, [req.body.user_id], (err, rows) => {
                console.log(rows);
                res.json({ modifyRes: 'success', data: rows })

            })

        } else {
            res.json({ modifyRes: 'failed' })
        }
        // 쿼리 결과 처리
        // console.log(rows);
        // res.send(rows);
        //     req.session.member = rows
        //     req.session.save(()=>{
        //     res.redirect('/')
        //   });
    });
});

module.exports = router;
