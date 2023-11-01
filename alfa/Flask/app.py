from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql
import pandas as pd
import joblib
from selenium import webdriver

app = Flask(__name__)
CORS(app)

# MySQL 데이터베이스 연결 설정
db = pymysql.connect(host='project-db-campus.smhrd.com',
                     user='ditto',
                     password='ditto',
                     db='ditto',
                     charset='utf8',
                     port=3307)

# .pkl 파일 경로
# file_path = 'C:/Users/smhrd/Desktop/ALFA_model.pkl'
file_path = 'C:/Users/smhrd/Desktop/실전프로젝트/데이터/ALFA_model.pkl' # 희주

# 머신러닝 모델 로드
loaded_model = joblib.load(file_path)


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


print('a' ,predict_value)


# 8. dio.dart에서 보낸 4개 값을 받음
@app.route('/result', methods=['POST'])

def predict():
 
    try:
        alData = request.get_json()
        tensA = alData.get('tens')
        yieldB = alData.get('yield')
        hardC = alData.get('hard')
        elongationD = alData.get('elongation')
        user_id = alData.get('user_id')
        pay_date = alData.get('pay_date')
    
        # 9. 여기까지 받아온 값 확인하기
        print(tensA, yieldB, hardC, elongationD, user_id, pay_date)
        
        # 10. 여기부터 모델링 작업, 입력 받은 값 4개 넣어주기
        alloy_info = [{'최대인장강도' : tensA,
                    '항복강도' : yieldB,
                    '연신율' : hardC,
                    '경도' : elongationD}]

        data = pd.DataFrame(alloy_info)
        # 예측 수행
        prediction = predict_value(data)

        # 결과 값 확인
        print(prediction)

        # return jsonify({'prediction':prediction})

        # 11. 여기부터 서버 연결시키기 
        
        


        # 사용자 입력을 데이터베이스에 저장 (SQL 인젝션 방어)
        # cursor = db.cursor()
        # insert_query = "INSERT INTO alloy_info (input_value) VALUES (%s)"
        # cursor.execute(insert_query, (alloy_info,))
        # db.commit()
        # cursor.close()
        return '완료'
   
    except Exception as e:
        return jsonify({'error': str(e)})
        # return '오류'

if __name__ == '__main__':
    app.run()


