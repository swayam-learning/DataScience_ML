from flask import Flask, render_template, request
import pickle
import numpy as np

# Load the pickle file containing the trained model
with open('model.pkl', 'rb') as file:
    model = pickle.load(file)

# Initialize Flask app
app = Flask(__name__)

@app.route('/')
def index():
    # Render the main page
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get form inputs
        cgpa = float(request.form.get('cgpa', 0))
        iq = float(request.form.get('iq', 0))

        # Prepare input for the model
        features = np.array([[cgpa, iq]])

        # Make a prediction using the loaded model
        prediction = model.predict(features)[0]

        # Interpret the result
        result = "Placed" if prediction == 1 else "Not Placed"

    except Exception as e:
        # Handle errors
        result = f"Error: {str(e)}"

    # Render the prediction result
    return render_template('index.html', prediction=result)

if __name__ == '__main__':
    app.run(debug=True)
