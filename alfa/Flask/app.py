from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql
import pandas as pd
import joblib
import numpy as np

app = Flask(__name__)
CORS(app)

# MySQL 데이터베이스 연결 설정
db = pymysql.connect(host='project-db-campus.smhrd.com',
                     user='ditto',
                     password='ditto',
                     db='ditto',
                     charset='utf8',
                     port=3307,
                     init_command='SET time_zone = "+00:00";')
cursor = db.cursor()

# .pkl 파일 경로
file_path = 'C:/Users/smhrd/Desktop/ALFA_model.pkl'
# file_path = 'C:/Users/smhrd/Desktop/실전프로젝트/데이터/ALFA_model.pkl' # 희주

# 머신러닝 모델 로드
loaded_model = joblib.load(file_path)
print('/result 이전 확인용 출력', loaded_model)

def predict_value(data):
    # 머신러닝 모델 호출 및 예측 수행
    predicted_value = loaded_model.predict(data)
    return predicted_value


# 증식


    
# np.array(row, dtype=object) *

    # 각 행 별로 데이터 증식
    
#


# 8. dio.dart에서 보낸 4개 값을 받음
@app.route('/result', methods=['POST'])

def predict():
 
    try:
        alData = request.get_json()
        tensA = alData.get('tens')
        yieldB = alData.get('yield')
        elongationC = alData.get('elongation')
        hardD = alData.get('hard')
        user_id = alData.get('user_id')
        pay_date = alData.get('pay_date')
        alnum = alData.get('alnum')
        research = alData.get('research')
    
        # 9. 여기까지 받아온 값 확인하기
        print(tensA, yieldB, elongationC, hardD, user_id, pay_date, alnum, research)
        
        def augment_data(row, percentage=0.02):
            augmented_data = []
            for _ in range(100):
                augmented_row = np.array(row, dtype=float) * (1 + np.random.uniform(-percentage, percentage, size=len(row)))
                augmented_data.append(augmented_row)
            return augmented_data
        
        # 10. 여기부터 모델링 작업, 입력 받은 값 4개 넣어주기
        new_alloy_info = [{'최대인장강도(UTS, MPa)' : tensA,
                    '항복강도(YS, MPa)' : yieldB,
                    '연신율(EL, %)' : elongationC,
                    '경도(Hardness, Hv)' : hardD}]
        data = pd.DataFrame(new_alloy_info)
        # 예측 수행
        print("위치1 : ",data.shape)
        
        
        
        # augmented_data = []
        # for row in data.iterrows():
        #     print("위치2 : 여기도?")

        #     print(augmented_data)
            # print("위치2 : 여기는?")
            
        #     augmented_data.extend(augment_data(row, percentage=0.02))
        
        augmented_data = []
        for row in data.itertuples(index=False):
            augmented_data.extend(augment_data(row, percentage=0.02))
            # print("위치2 : 여기도?")
            # print("위치2 : 여기는?")
        increase_condition = pd.DataFrame(augmented_data, columns=data.columns)
        print(increase_condition)
        
        
        print("위치2 : 여기도???")
        # 결과 데이터프레임 생성
        
        print("위치3 : 결과는?")
        # 결과 소수점 2번째자리까지만!
        increase_condition2 = increase_condition.round(2)
        # 결과 출력
        # print(increase_condition2)       


        # 예측 수행
        prediction = predict_value(increase_condition2)
        print(prediction)
        
        incResult = np.unique(prediction)
        # 결과 값 확인
        print("결과값1:",incResult)
        # print("결과값2:",incResult[1])
        
        
        # prediction = predict_value(data)[0]

        # 결과 값 확인
        # print("결과값:",prediction)




        # 사용자 입력을 데이터베이스에 저장 (SQL 인젝션 방어)
        
        query = """SELECT * FROM alloy_info where num = %s"""
        cursor.execute(query, incResult[0])
        # cursor.execute(query)

# 결과 가져오기
        result = cursor.fetchall()

# 결과 출력
        for row in result:
            num = row[0]
            name = row[1]
            casting = row[2]
            sol1_deg = row[3]
            sol1_time = row[4]
            quench = row[5]
            sol2_deg = row[6]
            sol2_time = row[7]
            quench2 = row[8]
            age_deg = row[9]
            age_time = row[10]
            tens = row[11]
            yiel = row[12]
            elongation = row[13]
            hard = row[14]
        
        print(row[0])
        print(row[1])
        db.commit()
        
        update = """update new_alloy_info set name = %s ,casting = %s, sol1_deg = %s, sol1_time = %s, quench = %s, sol2_deg = %s, sol2_time = %s, quench2 = %s, age_deg = %s, age_time = %s, tens = %s, yield = %s, elongation = %s, hard = %s where num = %s"""
        # # cursor.execute(insert_query, (alloy_info,))
        cursor.execute(update ,(name, casting,sol1_deg,sol1_time,quench,sol2_deg,sol2_time,quench2,age_deg,age_time,tens,yiel,elongation,hard,alnum)) 
        
        db.commit()
        
        
        
        
        
        
        
        
        
        
        
        
        
        select = """select * from new_alloy_info where researchDate = %s"""
        cursor.execute(select, research)
        # cursor.execute(select)
        
        
        resData = cursor.fetchall()
        print(resData)
        print('research', research)
        
        db.commit()
        
        # cursor.close()
        return jsonify(resData)
   
    except Exception as e:
        return jsonify({'error': str(e)})
        # return '오류'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


