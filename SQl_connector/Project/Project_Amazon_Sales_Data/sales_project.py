import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

st.set_page_config(layout="wide",page_title="Startup Analysis")

df = pd.read_csv("Amazon Sale Report Cleaned.csv")
df1 = df.groupby("Courier Status")

def Product_Status(column):
    st.write("Value counts:")
    st.write(df[column].value_counts().head())
    categories = ["Shipped","On the Way","Cancelled","Unshipped"]
    products_sales = [8546,641,438,370]
    fig,ax1= plt.subplots(figsize=(4,5),facecolor='black')
    ax1.pie(products_sales,labels=categories,explode=[0.15,0,0,0],shadow=True,autopct="%1.1f%%",textprops=dict(color="white"))
    plt.title("Total Products Status",color="white")
    st.pyplot(fig)

def High_Cancellation(**args):
    fig,ax1 = plt.subplots(figsize=(10,5))
    cancellation =df[df["Courier Status"]=="Cancelled"]["Category"].value_counts()
    ax1.bar(cancellation.index,cancellation.values)
    plt.title("Highest Cancellation Products")
    st.pyplot(fig)
    

st.sidebar.title("Frequently Asked Questions")

option = st.sidebar.selectbox("Select One",["Product Delivery Status","Categories with Highest Cancellation","Investor"])

if option == "Product Delivery Status":
    st.title("Product Delivery Status")
    btn1 = st.sidebar.button("Details")
    if btn1:
        Product_Status("Courier Status")

elif option == "Categories with Highest Cancellation":
    btn2 = st.sidebar.button("Details")
    if btn2:
       High_Cancellation()
## run using streamlit run python_file.py