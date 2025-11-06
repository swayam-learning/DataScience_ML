import streamlit as st
import pickle
import numpy as np

# Load the trained logistic regression model
with open('model.pkl', 'rb') as file:
    model = pickle.load(file)

def main():
    st.title("Student Placement Prediction")

    st.write("This app predicts whether a student will be placed based on CGPA and IQ.")

    # Input fields for CGPA and IQ
    cgpa = st.number_input("Enter CGPA:", min_value=0.0, max_value=10.0, step=0.01, format="%.2f")
    iq = st.number_input("Enter IQ:", min_value=0, max_value=200, step=1)

    # Predict button
    if st.button("Predict"):
        try:
            # Prepare the input for prediction
            features = np.array([[cgpa, iq]])
            
            # Predict using the loaded model
            prediction = model.predict(features)[0]
            
            # Display the result
            result = "Placed" if prediction == 1 else "Not Placed"
            st.success(f"Prediction: {result}")
        except Exception as e:
            st.error(f"Error: {e}")

if __name__ == "__main__":
    main()
