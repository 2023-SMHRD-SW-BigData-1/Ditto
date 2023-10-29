import joblib

# .pkl 파일 경로
file_path = 'C:\\Users\\smhrd\\Desktop\\실전프로젝트\\데이터\\emsemble_model.pkl'

# .pkl 파일 열기
loaded_model = joblib.load(file_path)

# 데이터를 출력하거나 사용합니다
print(loaded_model)
