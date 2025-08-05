from flask import Flask 
from router.user import user_bp 

app = Flask(__name__)
app.register_blueprint(user_bp)

@app.route("/")
def index():
    return {"message":"API Python Flask en ejecucion"}, 200

if __name__=="__main__":
    app.run(host="0.0.0.0", port=5000)