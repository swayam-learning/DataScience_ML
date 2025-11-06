from flask import Flask,render_template,request,redirect,json
import requests
from database import databases
app = Flask(__name__)

databases_object = databases()
# this is the trigger point.
@app.route("/") #used to create route or url. 
def index():
    return render_template("login.html")

@app.route("/register")
def register():
    return render_template("register.html")

@app.route("/perform_registration", methods=['POST'])
def perfomance_registration():
    name = request.form.get("user_name")
    email = request.form.get("user_email")
    password = request.form.get("user_password")
    response = databases_object.insert_data(name,email,password)
    if(response==1):
        return render_template("login.html",message="Registration Successful Kindly Login Here")
    else:
        return render_template("register.html",message="Email already exists")


@app.route("/perform_login",methods = ['POST'])
def perform_login():
    email = request.form.get("user_email")
    password = request.form.get("user_password")

    response = databases_object.search(email,password)
    if response:
        return redirect("/profile")
    else:
        return render_template("login.html",mess="Incorrect email/password")
    
@app.route("/profile")
def profile():
    return render_template("profile.html")

@app.route("/ner", methods=['GET', 'POST'])
def ner():
    if request.method == 'POST':
        # Get the text from the form
        text = request.form.get('text')

        if text:
            # Call the NER API
            headers = {
                "Authorization": "Bearer <your own api key>"
            }
            url = "https://api.edenai.run/v2/text/named_entity_recognition"
            payload = {
                "providers": "google",
                "language": "en",
                "text": text,
            }
            response = requests.post(url, json=payload, headers=headers)

            if response.status_code == 200:
                result = json.loads(response.text)
                print(result)  # Debug print to inspect the API response structure

                formatted_result = format_ner_result(result)
                print(formatted_result)  # Debug print for formatted result

                return render_template("ner.html", result=formatted_result)
            else:
                error_message = f"API Error: {response.status_code} - {response.text}"
                print(error_message)  # Debug print for API error
                return render_template("ner.html", error=error_message)

        else:
            return render_template("ner.html", error="Please enter text to perform NER.")

    return render_template("ner.html")

def format_ner_result(result):
    formatted_result = {}

    for provider, data in result.items():
        entities_by_type = {}
        for item in data.get('items', []):
            entity_type = item.get('category', 'Unknown')
            entity_text = item.get('entity', 'Unknown')
            if entity_type not in entities_by_type:
                entities_by_type[entity_type] = []
            entities_by_type[entity_type].append(entity_text)

        formatted_result[provider] = entities_by_type

    return formatted_result

if __name__ == "__main__":
    app.run(debug=True)
# def sa():
#     return "Sentiment Analysis"

# @app.route("/fr")
# def fr():
#     return "Face Recognition"

# app.run(debug = True)