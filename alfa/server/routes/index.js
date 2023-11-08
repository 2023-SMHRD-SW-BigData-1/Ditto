const express = require('express')
const router = express.Router()
const dbConfig = require('../config/database');

let conn = dbConfig.init();
dbConfig.connect(conn);

// ---------------------------------------------------------------------------------------- 로그인 시작
router.post('/user/login', (req, res) => {
    let sql = "SELECT * FROM user_info where user_id = ?"
    //
    console.log("server login req : " + [req.body.user_id]);
    //
    conn.query(sql, [req.body.user_id], (err, rows) => {
        if (rows[0] !== undefined) {
            if (rows[0].user_id === req.body.user_id) {
                if (rows[0].user_pw === req.body.user_pw) {
                    res.json({ result: 'success', data: rows })
                } else if (rows[0].user_pw !== req.body.user_pw) {
                    res.json({ result: 'pw err' })
                }
            }
        } else {
            res.json({ result: 'empty id' })
        }
    });
});
// ---------------------------------------------------------------------------------------- 로그인 종료

// ---------------------------------------------------------------------------------------- 회원가입 시작
router.post('/user/create', (req, res) => {
    let sql = "select user_id from user_info where user_id = ?";
    conn.query(sql, [req.body.user_id], (err, rows) => {
        console.log(rows, req.body.user_id);
        if (rows[0] == undefined) {
            let sql2 = "insert into user_info values(?, ?, '0', ?, ?, now(), null)";
            console.log("req : " + [req.body.user_id]);
            console.log("req : " + [req.body.user_pw]);
            console.log("req : " + [req.body.user_name]);
            console.log("req : " + [req.body.user_num]);

            conn.query(sql2, [req.body.user_id, req.body.user_pw, req.body.user_name, req.body.user_num], (err, rows) => {
                console.log('insert : ' + rows[0]);
                if (rows != undefined) {
                    console.log('server join ? : success');
                    let sql3 = "select * from user_info where user_id = ?";
                    conn.query(sql3, [req.body.user_id], (err, rows) => {
                        res.json({ result: 'success', data: rows })

                    })
                } else {
                    res.json({ result: 'failed' })
                }
            }
            )
        } else {
            console.log('server join ? : existed id');
            res.json({ result: 'failed' })

        }
    })

});
// ---------------------------------------------------------------------------------------- 회원가입 종료

// ---------------------------------------------------------------------------------------- 정보 수정 시작
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
// ---------------------------------------------------------------------------------------- 정보 수정 종료

// ---------------------------------------------------------------------------------------- 정보 페이지 결제 내역 시작
router.post('/info/loadpay', (req, res) => {
    let sql = "select * from pay_date where user_id = ?;"

    conn.query(sql, [req.body.user_id], (err, rows) => {
        if (rows != undefined) {
            console.log(rows)
            // var rows1 = [];
            // var num = rows.length
            // if(num == 1){
            //     rows1 = [rows];
            // }else {
            //     rows1 = rows;
            // }
            res.json({ loadpay: 'success', data: rows })

        } else if (err) {
            console.log('err')
            res.json({ loadpay: 'failed' })
        }

    });
});
// ---------------------------------------------------------------------------------------- 정보 페이지 결제 내역 종료

// ---------------------------------------------------------------------------------------- 예측 시작
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
            let sql2 = "select num, name, casting, sol1_deg, sol1_time, quench, sol2_deg, sol2_time, quench2, age_deg, age_time, tens,yield,elongation, hard, user_id, pay_date, DATE_FORMAT(researchDate, '%Y-%m-%d %H:%i:%s') AS researchDate from new_alloy_info where pay_date = ? order by num desc;"
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
// ---------------------------------------------------------------------------------------- 예측 종료

// ---------------------------------------------------------------------------------------- 일반 결제 시작
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
// ---------------------------------------------------------------------------------------- 일반 결제 종료

// ---------------------------------------------------------------------------------------- 라이센스 시작 
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
// ---------------------------------------------------------------------------------------- 라이센스 종료

// ---------------------------------------------------------------------------------------- 결제일 출력 시작
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
// ---------------------------------------------------------------------------------------- 결제일 출력 종료

module.exports = router;
