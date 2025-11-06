import streamlit as st
import pickle
import pandas as pd
from sklearn.pipeline import Pipeline

# Title and description
st.title("Decision Tree Classifier App")
st.write("This app uses a pre-trained Decision Tree model to make predictions.")

# Load the pickled model from a local file
MODEL_PATH = "model.pkl"  # Replace with the actual path to your model file
try:
    with open(MODEL_PATH, "rb") as file:
        model = pickle.load(file)
        st.success("Model successfully loaded from local file!")

        # Input features form
        st.write("## Enter feature values:")
        
        # Create inputs dynamically (customize based on your feature set)
        Pclass = st.selectbox("Passenger Class (Pclass):", options=[1, 2, 3])
        Sex = st.selectbox("Sex:", options=["male", "female"])
        Age = st.slider("Age:", min_value=0, max_value=100, value=25)
        SibSp = st.number_input("Number of Siblings/Spouses aboard (SibSp):", min_value=0, value=0)
        Parch = st.number_input("Number of Parents/Children aboard (Parch):", min_value=0, value=0)
        Fare = st.number_input("Passenger Fare (Fare):", min_value=0.0, value=15.0)
        Embarked = st.selectbox("Port of Embarkation:", options=["C", "Q", "S"])

        # Map inputs to a DataFrame
        input_data = pd.DataFrame({
            "Pclass": [Pclass],
            "Sex": [Sex],
            "Age": [Age],
            "SibSp": [SibSp],
            "Parch": [Parch],
            "Fare": [Fare],
            "Embarked": [Embarked]
        })

        st.write("### Input Data:")
        st.write(input_data)

        # Make predictions
        if st.button("Predict"):
            prediction = model.predict(input_data)
            st.write("## Prediction:", prediction[0])
except FileNotFoundError:
    st.error(f"Model file not found at {MODEL_PATH}. Please ensure the file exists and try again.")
except Exception as e:
    st.error(f"An error occurred while loading the model: {e}")
