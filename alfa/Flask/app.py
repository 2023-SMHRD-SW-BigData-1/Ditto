from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql
import joblib

app = Flask(__name__)

# CORS 설정: 특정 출처에서의 요청만 허용
CORS(app, resources={r"/api/result": {"origins": "https://localhost:5000"}})

# MySQL 데이터베이스 연결 설정
db = pymysql.connect(host='project-db-campus.smhrd.com',
                     user='ditto',
                     password='ditto',
                     db='ditto',
                     charset='utf8',
                     port=3307)

# .pkl 파일 경로
file_path = 'C:\\Users\\smhrd\\Desktop\\실전프로젝트\\데이터\\emsemble_model.pkl'

# 머신러닝 모델 로드
loaded_model = joblib.load(file_path)

# print(loaded_model)

# 예측 함수
def predict_value(alloy_info):
    # 머신러닝 모델 호출 및 예측 수행
    predicted_value = loaded_model.predict(alloy_info)
    return predicted_value

# print(predict_value)

# API 엔드포인트 등록
@app.route('/api/user/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        alloy_info = data['alloy_info']

        # 예측 수행
        prediction = predict_value(alloy_info)

        print(prediction)

        # 사용자 입력을 데이터베이스에 저장 (SQL 인젝션 방어)
        cursor = db.cursor()
        insert_query = "INSERT INTO alloy_info (input_value) VALUES (%s)"
        cursor.execute(insert_query, (alloy_info,))
        db.commit()
        cursor.close()

        return jsonify({'prediction': prediction})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host='localhost', port=5000, debug=True)
