from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql

app = Flask(__name__)
CORS(app)

# MySQL 데이터베이스 연결 설정
db = pymysql.connect(host='project-db-campus.smhrd.com',
                     user='ditto',
                     password='ditto',
                     db='ditto',
                     charset='utf8',
                     port=3307)

# 가상의 머신러닝 모델 함수
def predict_value(user_input):
    # 여기에서 머신러닝 모델을 호출하고 예측 수행
    predicted_value = float(user_input) * 2
    return predicted_value

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    user_input = data['user_input']
    prediction = predict_value(user_input)

    # 사용자 입력을 데이터베이스에 저장 (옵션)
    cursor = db.cursor()
    insert_query = "INSERT INTO user_inputs (input_value) VALUES (%s)"
    cursor.execute(insert_query, (user_input,))
    db.commit()
    cursor.close()

    return jsonify({'prediction': prediction})

if __name__ == '__main__':
    app.run(host='localhost', port=5000, debug=True)
