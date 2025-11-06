import streamlit as st
import requests

# Replace with your Gemini API key
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Access the API key
api_key = os.getenv('API_KEY')
API_URL = f'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key={api_key}'

# Function to get Gemini's response
def get_gemini_response(user_input):
    headers = {
        'Content-Type': 'application/json'
    }
    data = {
        "contents": [{
            "parts": [{"text": user_input}]
        }]
    }
    try:
        response = requests.post(API_URL, headers=headers, json=data)
        response.raise_for_status()  # Raises an HTTPError for bad responses
        response_json = response.json()
        # Extract the generated text from the response
        generated_text = response_json['candidates'][0]['content']['parts'][0]['text']
        return generated_text
    except requests.exceptions.HTTPError as errh:
        return f"HTTP Error: {errh}"
    except requests.exceptions.ConnectionError as errc:
        return f"Error Connecting: {errc}"
    except requests.exceptions.Timeout as errt:
        return f"Timeout Error: {errt}"
    except requests.exceptions.RequestException as err:
        return f"Oops: Something went wrong: {err}"
    except KeyError as errk:
        return f"Error parsing response: {errk}"

# Streamlit App
def main():
    st.title("Gemini Chatbot 🚀")
    st.write("Welcome to the Gemini Chatbot! Type your message below and press Enter to chat.")

    # Initialize session state to store chat history
    if "chat_history" not in st.session_state:
        st.session_state.chat_history = []

    # Input from user
    user_input = st.chat_input("Type your message here...")

    if user_input:
        # Add user input to chat history
        st.session_state.chat_history.append({"role": "user", "text": user_input})

        # Get Gemini's response
        gemini_response = get_gemini_response(user_input)

        # Add Gemini's response to chat history
        st.session_state.chat_history.append({"role": "assistant", "text": gemini_response})

    # Display chat history
    for message in st.session_state.chat_history:
        with st.chat_message(message["role"]):
            st.write(message["text"])

# Run the app
if __name__ == "__main__":
    main()