import streamlit as st
from db_helper import DB
db = DB()
st.sidebar.title("Flight Analytics")

user_option = st.sidebar.selectbox('Menu',['Select One','Check Flights','Analytics'])

if user_option == 'Check Flights':

    st.title('Check Flights')

    col1,col2 = st.columns(2)
    city = db.fetch_city_names()

    with col1:
        source = st.selectbox('Source',sorted(city))
    with col2:
        destination = st.selectbox('Destination',sorted(city))
    
    if st.button('Search'):
        result = db.fetch_all_flights(source,destination)
        st.dataframe(result)

elif user_option == 'Analytics':
    st.title('Analytics')
    airline,frequency = db.fetch_airline_frequency()
    import pandas as pd
    import plotly.graph_objects as go

    df = pd.DataFrame({
        'Airline': airline,
        'Frequency': frequency
    })

     # Find the index of the max frequency
    max_index = df['Frequency'].idxmax()

    # Create pull list: 0 for others, 0.1 for the one with max frequency
    pull = [0.08 if i == max_index else 0 for i in range(len(df))]


    # Plot pie chart
    fig = go.Figure(
        data=[go.Pie(
            labels=df['Airline'],
            values=df['Frequency'],
            pull=pull,
            hole=0  # Set hole >0 if you want donut style
        )]
    )

    fig.update_layout(title='Airline Booking Frequency')

    st.plotly_chart(fig)

else:
    st.title('Tell about the Project')

