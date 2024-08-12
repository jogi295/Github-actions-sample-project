from flask import Flask, request, render_template
import os
import signal

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/add', methods=['POST'])
def add():
    num1 = float(request.form['num1'])
    num2 = float(request.form['num2'])
    result = num1 + num2
    return render_template('index.html', result=f"Addition Result: {result}")

@app.route('/subtract', methods=['POST'])
def subtract():
    num1 = float(request.form['num1'])
    num2 = float(request.form['num2'])
    result = num1 - num2
    return render_template('index.html', result=f"Subtraction Result: {result}")

@app.route('/stop', methods=['POST'])
def stop():
    os.kill(os.getpid(), signal.SIGINT)
    return "Server stopped"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
