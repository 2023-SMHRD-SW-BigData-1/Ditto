from flask import Flask, request, jsonify
import pymysql

app = Flask(__name__)

# MySQL 연결 설정
connection = pymysql.connect(host='project-db-campus.smhrd.com',
                            user='ditto',
                            password='ditto',
                            db='ditto',
                            charset='utf8',
                            port=3307)

@app.route('/', methods=['GET'])
def get_data():
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM user_info")
    results = cursor.fetchall()
    cursor.close()
    return jsonify(results)

if __name__ == '__main__':
    app.run('0.0.0.0', port=5000, debug=True)
