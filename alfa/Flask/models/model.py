from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)

# .pkl 파일 경로
file_path = 'C:\\Users\\smhrd\\Desktop\\실전프로젝트\\데이터\\emsemble_model.pkl'

# 모델을 글로벌 변수로 로드 (한 번만 로드)
loaded_model = joblib.load(file_path)

@app.route('/api/predict', methods=['POST'])
def predict():
    try:
        # 클라이언트로부터 데이터를 받아옴
        data = request.get_json()

        # 데이터를 출력하거나 사용합니다
        print(loaded_model)

        # 머신러닝 모델을 사용하여 예측
        prediction = loaded_model.predict(data)

        # 예측 결과를 JSON 형식으로 반환
        return jsonify({'prediction': prediction})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
