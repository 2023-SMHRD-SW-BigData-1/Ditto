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

def predict_value(data):
    # 머신러닝 모델 호출 및 예측 수행
    predicted_value = loaded_model.predict(data)
    return predicted_value


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
        
        def augment_data(row, percentage=0.05):
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
        
        augmented_data = []
        for row in data.itertuples(index=False):
            augmented_data.extend(augment_data(row, percentage=0.05))
        increase_condition = pd.DataFrame(augmented_data, columns=data.columns)
        print(increase_condition)
        
        # 결과 데이터프레임 생성        

        # 결과 소수점 2번째자리까지만!
        increase_condition2 = increase_condition.round(2)
        # 결과 출력     

        # 예측 수행
        prediction = predict_value(increase_condition2)
        print('----------')

        # 결과값의 개수가 많은 순으로 정렬
        unique_values, counts = np.unique(prediction, return_counts=True)
        sorted_indices = np.argsort(-counts)
        unique_values = unique_values[sorted_indices]
        counts = counts[sorted_indices]
        
        print('sorted : ', sorted_indices)
        print('values : ', unique_values)
        print('counts : ', counts)
        
        new_value=[]
        new_count=[]
        for value, count in zip(unique_values, counts):
            print(f"값 {value}: {count}개")
            if count >= 20:
                new_value.append(value)
                new_count.append(count)
        print('----------')
        
        print('new_value : ', new_value)
        print('new_count : ', new_count)
        
        for i in range(3) :
            if i < len(new_value) :
                print(f'{i+1}번째', new_value[i])
        print('-------------')
        print("선택지 : " , new_value)
        

        # 사용자 입력을 데이터베이스에 저장 (SQL 인젝션 방어)

# ---------------------------------------------- 결과값이 1개일 때

        if len(new_value) == 1 :
            query = """SELECT * FROM alloy_info where num = %s"""
            cursor.execute(query, new_value[0])
        

# 결과 가져오기
            result = cursor.fetchall()

# 결과 출력
            for row in result:
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

            db.commit()

            update = """update new_alloy_info set name = %s ,casting = %s, sol1_deg = %s, sol1_time = %s, quench = %s, sol2_deg = %s, sol2_time = %s, quench2 = %s, age_deg = %s, age_time = %s where num = %s"""
            cursor.execute(update ,(name, casting,sol1_deg,sol1_time,quench,sol2_deg,sol2_time,quench2,age_deg,age_time,alnum)) 
            print('------------------1개일 때 업데이트 완료')
            db.commit()
        
# ---------------------------------------------- 결과값이 2개일 때
        elif len(new_value) == 2 :
            query = """SELECT * FROM alloy_info where num = %s"""
            cursor.execute(query, new_value[0])
        
# 결과 가져오기
            result = cursor.fetchall()

# 결과 출력
            for row in result:
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

            db.commit()

            update = """update new_alloy_info set name = %s ,casting = %s, sol1_deg = %s, sol1_time = %s, quench = %s, sol2_deg = %s, sol2_time = %s, quench2 = %s, age_deg = %s, age_time = %s where num = %s"""
            cursor.execute(update ,(name, casting, sol1_deg, sol1_time, quench, sol2_deg, sol2_time, quench2, age_deg, age_time, alnum)) 

            query = """SELECT * FROM alloy_info where num = %s"""
            cursor.execute(query, new_value[1])
            result = cursor.fetchall()

# 결과 출력
            for row in result:
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

            db.commit()
            
            query3 = """insert into new_alloy_info values (default, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
            cursor.execute(query3, (name, casting,sol1_deg,sol1_time,quench,sol2_deg,sol2_time,quench2,age_deg,age_time,tensA,yieldB,elongationC, hardD, user_id, pay_date, research))
            print("2개일 때 insert 완료")

            db.commit()
        
        
# ---------------------------------------------- 결과값이 3개일 때
# ---------------------------------------------- 1번째 합금 정보 가져오기
        elif len(new_value) == 3 :
            query = """SELECT * FROM alloy_info where num = %s"""
            cursor.execute(query, new_value[0])
        
        

# 결과 가져오기
            result = cursor.fetchall()

# 결과 출력
            for row in result:
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

            db.commit()

            update = """update new_alloy_info set name = %s ,casting = %s, sol1_deg = %s, sol1_time = %s, quench = %s, sol2_deg = %s, sol2_time = %s, quench2 = %s, age_deg = %s, age_time = %s where num = %s"""
            cursor.execute(update ,(name, casting, sol1_deg, sol1_time, quench, sol2_deg, sol2_time, quench2, age_deg, age_time, alnum)) 

# ---------------------------------------------- 2번째 합금 정보 가져오기
            query = """SELECT * FROM alloy_info where num = %s"""
            cursor.execute(query, new_value[1])
            result = cursor.fetchall()

# 결과 출력
            for row in result:
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

            db.commit()
            
            query3 = """insert into new_alloy_info values (default, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
            cursor.execute(query3, (name, casting,sol1_deg,sol1_time,quench,sol2_deg,sol2_time,quench2,age_deg,age_time,tensA,yieldB,elongationC, hardD, user_id, pay_date, research))
            print("3개일 때 insert1 완료")

            db.commit()
            

# ---------------------------------------------- 3번째 합금 정보 가져오기            

            query = """SELECT * FROM alloy_info where num = %s"""
            cursor.execute(query, new_value[2])
            result = cursor.fetchall()

# 결과 출력
            for row in result:
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

            db.commit()
            
            query3 = """insert into new_alloy_info values (default, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
            cursor.execute(query3, (name, casting,sol1_deg,sol1_time,quench,sol2_deg,sol2_time,quench2,age_deg,age_time,tensA,yieldB,elongationC, hardD, user_id, pay_date, research))
            print("3개일 때 insert1 완료")

            db.commit()
        
        
        
        
        
        
        
        
        select = """select * from new_alloy_info where researchDate = %s"""
        cursor.execute(select, research)
        
        
        
        resData = cursor.fetchall()
        
        print('res data : ', resData)
        print('type res data : ', type(resData))
        print('new count : ', new_count)
        print('type new count : ', type(new_count))
        # new_cnt = new_count.tolist()
        # print('new_cnt : ', new_cnt)
        # str_count = [str(num) for num in new_count]
        count_new = tuple(new_count)
        converted_tuple = tuple(int(x) if isinstance(x, np.int64) else x for x in count_new)
        # res = [count_new, resData]
        # for i in range(0, len(new_count)):
        #     new_count = (new_count[i], ) + resData[i]
        #     new_res = f"count_new{i}"
            # total_res = (new_res)
        
        if (len(converted_tuple) == 1):
            total_res = (converted_tuple[0], ) + resData[0]
        elif (len(converted_tuple) == 2):
            count_new1 = (converted_tuple[0], ) + resData[0]
            count_new2 = (converted_tuple[1], ) + resData[1]
            total_res = (count_new1, count_new2)
        else :
            count_new1 = (converted_tuple[0], ) + resData[0]
            count_new2 = (converted_tuple[1], ) + resData[1]
            count_new3 = (converted_tuple[2], ) + resData[2]
            total_res = (count_new1, count_new2, count_new3)
            
            
        # print(total_res)
        # print('total_res type : ', type(total_res))
        

        # print(converted_tuple)
        # print(resData[0])
        db.commit()
        real_total_res = np.ndim(total_res)
        if real_total_res == 1:
            real_real_total_res = [total_res]
            return jsonify(real_real_total_res)
        else :
            return jsonify(total_res)
            
        # print('개수, 데이터 확인',total_res)
        
        # cursor.close()
   
    except Exception as e:
        return jsonify({'error': str(e)})
        # return '오류'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


