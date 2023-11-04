const express = require('express')
const app = express();

const router = express.Router()
const dbConfig = require('../config/database');
const e = require('express');

// const bodyParser = require('body-parser');

// const model = require('C:\\Users\\smhrd\\Desktop\\실전프로젝트\\데이터\\emsemble_model.pkl')

// app.use(bodyParser.json());
// // 모델 호츨 엔드포인트 설정
// app.post('/predict', (req,res)=>{
//     const inputData = req.body.data; // 클라이언트에서 전송된 데이터
//     const prediction = model.predict(inputData); // 모델 호출

//     // 결과 반환
//     res.json({prediction});
// })




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
                    console.log('login rows : ', rows[0]['user_type']);
                    res.json({ result: 'success', data: rows })
                    // if(rows[0]['user_type'] == 2){
                    //     let sql2 = "select pay_date from pay_date where user_id = ?"
                    //     conn.query(sql2, [req.body.user_id], (err, rows) => {
                    //         console.log('pay_date : ', rows[0])
                    //         res.json({pay_date : rows[0]})

                    //     })
                    // }
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
            let sql = "insert into user_info values(?, ?, '0', ?, ?, now(), null)";
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
    let sql = "update user_info set user_pw = ?, user_num = ? , user_update = DEFAULT where user_id = ?;"

    conn.query(sql, [req.body.user_pw, req.body.user_num, req.body.user_id], (err, rows) => {
        if (rows != undefined) {
            let sql2 = "select * from user_info where user_id = ?";
            conn.query(sql2, [req.body.user_id], (err, rows) => {
                res.json({ modifyRes: 'success', data: rows })
            })
        } else if (err) {
            console.log('err')
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


// dio.dart의 insertAl
// 2. url/main/stepOne 주소에서 받음
router.post('/main/stepOne', (req, res) => {
    // 2-1. 받아온 값을 DB에 넣어야 하기 때문에 쿼리문 작성
    let sql = "insert into new_alloy_info values (default, 'test','test', null, null , 'test', null , null , 'test', null , null , ?, ?, ?, ?, ?, ?, default);"
    // 2-2. 확인용 로그
    console.log('first data', req.body)
    // 2-3. 위의 sql 문의 ? 자리에 각각 값을 순서대로 넣어주고 실행함
    conn.query(sql, [req.body.tens, req.body.yield, req.body.elongation, req.body.hard, req.body.user_id, req.body.pay_date], (err, rows1) => {
        // 2-4. 입력이 제대로 됐다면~
        if (rows1 != undefined) {
            let sql2 = "select * from new_alloy_info where pay_date = ? order by num desc;"
            conn.query(sql2, [req.body.pay_date], (err, rows2) => {
                console.log('select new : ' + rows2[0]['researchDate'])
                res.json({ stepOne: 'success', pay: rows2 })
            })
            // 3. stepOne의 키에 success라는 값을 담은 json 형태를 dio.dart 로 돌려보내주기
            // 2-4-1. 제대로 안됐다면 ~
        } else {
            // 3-1. 무슨 에러인지 보여주고 failed 값 보내주기
            console.log('err', err)
            res.json({ stepOne: 'failed' })
        }
        // 4 dio.dart로 이동
    });
});

// 일반 결제 이후
router.post('/main/paydate', (req, res) => {
    // 2-1. 받아온 값을 DB에 넣어야 하기 때문에 쿼리문 작성
    let sql = "insert into pay_date values (default, 0, ?, ?, ?);"
    // 2-2. 확인용 로그
    console.log('pay first data', req.body)
    // 2-3. 위의 sql 문의 ? 자리에 각각 값을 순서대로 넣어주고 실행함
    conn.query(sql, [req.body.user_id, req.body.pay_date, req.body.pay_price], (err, rows) => {
        // 2-4. 입력이 제대로 됐다면~
        if (rows != undefined) {
            res.json({ payment: 'success' })

            // 3. stepOne의 키에 success라는 값을 담은 json 형태를 dio.dart 로 돌려보내주기

        } else if (err) {
            // 3-1. 무슨 에러인지 보여주고 failed 값 보내주기
            console.log('err', err)
            res.json({ payment: 'failed' })
        }
        // 4 dio.dart로 이동
    });
});

// 라이센스 결제 
router.post('/main/paydate2', (req, res) => {
    // 2-1. 받아온 값을 DB에 넣어야 하기 때문에 쿼리문 작성
    let sql = "update user_info set user_type = ? where user_id = ?;"
    // 2-2. 확인용 로그
    console.log('license update', req.body)
    // 2-3. 위의 sql 문의 ? 자리에 각각 값을 순서대로 넣어주고 실행함
    conn.query(sql, [req.body.user_type, req.body.user_id], (err, rows) => {
        // 2-4. 입력이 제대로 됐다면~
        if (rows != undefined) {
            res.json({ payment: 'success', license: rows })
            // 3. stepOne의 키에 success라는 값을 담은 json 형태를 dio.dart 로 돌려보내주기
            // 2-4-1. 제대로 안됐다면 ~
        } else if (err) {
            // 3-1. 무슨 에러인지 보여주고 failed 값 보내주기
            console.log('err', err)
            res.json({ payment: 'failed' })
        }
        // 4 dio.dart로 이동
    });
});

router.post('/main/loadPayDate', (req, res) => {
    let sql = "select pay_date from pay_date where user_id = ? order by date_num desc;"
    console.log(req.body.user_id)
    conn.query(sql, [req.body.user_id], (err, rows) => {
        // 2-4. 입력이 제대로 됐다면~
        if (rows != undefined) {
            console.log(rows[0])

            res.json({ loadPayDate: 'success', data: rows })
            // let sql2 = "update user_info set user_type = '1' where user_id = ?;"
            // conn.query(sql2, [req.body.user_id], (err, rows) => {
            //     if (rows != undefined) {
            //         res.json({ payment: 'success' })
            //     }
            // }
            // )
            // 3. stepOne의 키에 success라는 값을 담은 json 형태를 dio.dart 로 돌려보내주기
            // 2-4-1. 제대로 안됐다면 ~
        } else if (err) {
            // 3-1. 무슨 에러인지 보여주고 failed 값 보내주기
            console.log('err', err)
            res.json({ payment: 'failed' })
        }
        // 4 dio.dart로 이동
    });
});

module.exports = router;
