from flask import Blueprint, jsonify

user_api = Blueprint('user_api', __name__)

# API 엔드포인트
@user_api.route('/api/users', methods=['GET'])
def get_users():
    # 사용자 목록을 반환하는 코드
    users = [{'user_id': 1}, {'user_id': 2}]
    return jsonify(users)

@user_api.route('/api/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    # 특정 사용자 정보를 반환하는 코드
    user = {'id': user_id, 'name': '<User Name>'}
    return jsonify(user)
