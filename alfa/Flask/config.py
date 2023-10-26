from flask import Flask, jsonify
import pymysql

app = Flask(__name__)

# MySQL 연결 설정
db = pymysql.connect(host='project-db-campus.smhrd.com',
                     user='ditto',
                     password='ditto',
                     db='ditto',
                     charset='utf8',
                     port=3307)

@app.route('/get_data', methods=['GET'])
def get_data():
    cursor = db.cursor(pymysql.cursors.DictCursor)
    cursor.execute('SELECT * FROM alloy_info')
    data = cursor.fetchall()
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)