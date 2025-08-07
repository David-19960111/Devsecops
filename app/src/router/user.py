from flask import Blueprint, jsonify
from services.logic import get_users 

user_bp = Blueprint('user',__name__,url_prefix="/users")

@user_bp.route("/", methods=["GET"])
def list_users():
    users = get_users()
    return jsonify(users)