import boto3
from flask import Flask, request, redirect, jsonify
from werkzeug.exceptions import NotFound
import random
import string


def create_app():
    app = Flask(__name__)

    dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
    table = dynamodb.Table('url-shortener')

    def generate_short_id(num_chars=6):
        return ''.join(random.choices(string.ascii_letters + string.digits, k=num_chars))


    @app.route('/shorten', methods=['POST'])
    def shorten_url():
        original_url = request.json.get('url')
        if not original_url:
            return jsonify({'error': 'No URL provided'}), 400
        
        short_id = generate_short_id()

        table.put_item(Item={
            'short_id': short_id,
            'original_url': original_url
        })

        short_url = request.host_url + short_id
        return jsonify({'short_url': short_url, 'original_url': original_url})


    @app.route('/<short_id>')
    def redirect_to_original_url(short_id):
        response = table.get_item(Key={'short_id': short_id})
        if 'Item' not in response:
            raise NotFound()
        original_url = response['Item']['original_url']
        return redirect(original_url)

    return app
