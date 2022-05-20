from website import create_app

app = create_app(testing=False)

if __name__ == '__main__':
    #app.run(debug=True) #to run on debug mode
    app.run(host='0.0.0.0')