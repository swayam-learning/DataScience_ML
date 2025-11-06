# streamlit is a library based upon react and on backend it uses python
import streamlit as st
import pandas as pd
import time
st.title("Startup Dashboard")
st.header("I am learning streamlit")
st.subheader("I am loving it")
st.write("Barack Obama, the 44th President of the United States, was born in Honolulu, Hawaii, on August 4, 1961. He graduated from Harvard Law School and later served as a senator from Illinois. In 2009, he won the Nobel Peace Prize. Obama currently resides in Washington, D.C., with his wife, Michelle Obama. In recent years, he has focused on humanitarian work through the Obama Foundation")
st.markdown("""
### My favourite movies
    - Interstellar
    - Cars 3""")
st.code("""
        def foo(input):
            return foo**2
        
        x = foo(4)
        """)
st.latex("x^2 + y^2 + 2 = 0")

# Display Elements

df = pd.DataFrame({
    "name":["Swaym","Swarup","barik"],
    "marks":[50,60,70]
})
st.dataframe(df)

st.metric("Revenue","Rs 5L","200%")
st.json({
    "name":["Swaym","Swarup","barik"],
    "marks":[50,60,70]
})
st.image("image.png")
# st.video()
st.sidebar.title("sidebar title")
col1 , col2 = st.columns(2)
with col1:
    st.image("image.png")
with col2:
    st.title("Hey")

st.error("Login failed")

st.success("Login succesful")

st.info("this is info")

st.warning("this is warning")

bar  = st.progress(0)

for i in range(1,101):
    time.sleep(0.2)
    bar.progress(i)

# input 

email = st.text_input("enter email")
print(email)

date = st.date_input("Enter date")
print(date)

number = st.number_input("enter number")
print(number)

# buttons
