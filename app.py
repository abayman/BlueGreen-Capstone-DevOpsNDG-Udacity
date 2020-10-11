"""
main module flask app
"""
from flask import Flask, render_template

app = Flask(__name__,template_folder='initial-deployment')

@app.route('/')
def index():
    """
    main route
    """
    return render_template('initial.html')