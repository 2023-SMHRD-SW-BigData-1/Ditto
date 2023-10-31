from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql
import pandas as pd
import joblib
from selenium import webdriver

# wd = webdriver.Chrome()
# wd.get("http://localhost:5000")
# data = wd.execute_script("return window.localStorage.getItem('flutter.id');")

# print('localStorage' , data)

app = Flask(__name__)
CORS(app)

# CORS 설정: 특정 출처에서의 요청만 허용
# CORS(app, resources={r"/main": {"origins": "http://172.30.1.29:8889"}})

# MySQL 데이터베이스 연결 설정
db = pymysql.connect(host='project-db-campus.smhrd.com',
                     user='ditto',
                     password='ditto',
                     db='ditto',
                     charset='utf8',
                     port=3307)

# .pkl 파일 경로
file_path = 'C:/Users/smhrd/Desktop/dittoModel.pkl'

# 머신러닝 모델 로드
loaded_model = joblib.load(file_path)

# print(loaded_model)

# 예측 함수
alloy_info = [{'최대인장강도' : 200,
'항복강도' : 175,
'연신율' : 1.5,
'경도' : 140}]

data = pd.DataFrame(alloy_info)

def predict_value(data):
    # 머신러닝 모델 호출 및 예측 수행
    predicted_value = loaded_model.predict(data)
    return predicted_value

# print(predict_value)

# @app.route('/', methods=['GET'])
# def get_data():
#     cursor = db.cursor()
#     cursor.execute("SELECT * FROM user_info")
#     results = cursor.fetchall()
#     cursor.close()
    # return jsonify(results)
print('a' ,predict_value)

# API 엔드포인트 등록
# @app.route('/test', method=['POST'])
# def test():
#     return print('test')

@app.route('/result', methods=['POST'])

def predict():
    input_data = request.get_json('inputData')
    print(input_data)
    return '완료'
    
    
    # try:

    #     alloy_info = [{'최대인장강도' : 200,
    #                 '항복강도' : 175,
    #                 '연신율' : 1.5,
    #                 '경도' : 140}]

    #     data = pd.DataFrame(alloy_info)
    #     # 예측 수행
    #     prediction = predict_value(data)

    #     # print(prediction)

    #     # 사용자 입력을 데이터베이스에 저장 (SQL 인젝션 방어)
    #     # cursor = db.cursor()
    #     # insert_query = "INSERT INTO alloy_info (input_value) VALUES (%s)"
    #     # cursor.execute(insert_query, (alloy_info,))
    #     # db.commit()
    #     # cursor.close()
    #     # return (prediction)
    #     print('result', prediction)
    #     # return jsonify({'prediction': prediction})
    # except Exception as e:
    #     # return jsonify({'error': str(e)})
    #     return None

if __name__ == '__main__':
    app.run()
    # app.run(host='0.0.0.0', port=5000, debug=True)
