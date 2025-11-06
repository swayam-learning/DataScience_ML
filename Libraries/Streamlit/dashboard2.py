import streamlit as st
import pandas as pd
email = st.text_input("enter email")
password = st.text_input("enter password")
gender = st.selectbox("select gender",["male","female"])

btn = st.button("Login karle bhai")
if btn:
    if email == "swayam@gmail.com" and password=="2334":
        st.success("logged in")
        st.write(gender)
        st.balloons()
    else:
        st.error("Loggin failed")

#file uploader
file = st.file_uploader("upload csv file")
if file is not None:
    df = pd.read_excel(file)
    st.dataframe(df.describe())

