import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
st.set_page_config(layout="wide",page_title="Startup Analysis")
df = pd.read_csv("startup_funding_cleaned.csv")
df["Date"] = pd.to_datetime(df["Date"],errors="coerce", dayfirst=True)
#data cleaning
df["Investors"] = df["Investors"].fillna("Undisclosed")

# st.dataframe(df)
def load_investor_details(selected_investor):
    st.title(selected_investor)
    # last 5 round of investments done by the investor
    last5_rounds= df[df["Investors"].str.contains(selected_investor)].head()[["Date","Startup","Vertical","SubVertical","City","Round","Amount"]]
    st.subheader("Most Recent Investments")
    st.dataframe(last5_rounds)
    col1,col2 = st.columns(2)

    # biggest investments done by the investor
    with col1:
        biggest_investment = df[df["Investors"].str.contains(selected_investor)].groupby("Startup")["Amount"].sum().sort_values(ascending=False).head()
        st.subheader("Biggest Investments")
        fig,ax = plt.subplots(figsize=(5,5))
        ax.bar(biggest_investment.index,biggest_investment.values)
        st.pyplot(fig)
    
    # Vertical Invested by the Investor
    with col2:
        threshold = 0.05  # Categories contributing less than 5% will be grouped
        # Filter and group by 'Vertical' column and sum 'Amount'

        vertical_invested_in = df[df["Investors"].str.contains(selected_investor)].groupby("Vertical")["Amount"].sum()
        # Calculate total sum for percentage calculations
        total_invested = vertical_invested_in.sum()
        # Identify categories contributing less than the threshold (5% in this case)
        small_categories = vertical_invested_in[vertical_invested_in / total_invested < threshold]
        # Group small categories into 'Other' and recalculate the main data
        if not small_categories.empty:
            other_sum = small_categories.sum()  # Sum of all small categories
            vertical_invested_in = vertical_invested_in[vertical_invested_in / total_invested >= threshold]  # Keep only larger categories
            vertical_invested_in['Other'] = other_sum  # Add 'Other' category
        # Display section heading
        st.subheader("Sectors Invested In")
        # Create figure and axes with appropriate size
        fig1, ax1 = plt.subplots(figsize=(15, 16))  # Adjust figure size
        # Explode larger slices (optional)
        explode = [0.15 if val == max(vertical_invested_in) else 0 for val in vertical_invested_in]
        # Plot pie chart with larger font size for labels
        ax1.pie(vertical_invested_in, 
                labels=vertical_invested_in.index, 
                autopct="%2.1f%%", 
                textprops={'fontsize': 16},  # Increase font size
                explode=explode)
        # Add equal aspect ratio to ensure pie chart is circular
        ax1.axis('equal')
        # Display the chart in Streamlit
        st.pyplot(fig1)
    
    df["Year"]=df["Date"].dt.year
    year_series = df[df["Investors"].str.contains(selected_investor)].groupby("Year")["Amount"].sum()
    st.subheader("Year-On-Year Investments Done")
    fig2,ax2= plt.subplots(figsize=(10,5))
    ax2.plot(year_series.index,year_series.values)
    st.pyplot(fig2)

st.sidebar.title("Startup Funding Analysis")

option = st.sidebar.selectbox("Select One",["Overall Analysis","Startup","Investor"])

if option == "Overall Analysis":
    st.title("Overall Analysis")

elif option == "Startup":
    st.sidebar.selectbox("Select Startup",sorted(df["Startup"].unique().tolist()))
    btn1= st.sidebar.button("startup details")
    st.title("Startup Analysis")

else:
    selected_investor = st.sidebar.selectbox("Select Investor",(set(sorted(df["Investors"].str.split(",").sum()))))
    btn2 = st.sidebar.button("investor details")
    if btn2:
        load_investor_details(selected_investor)
    # st.title("Investor Analysis")





