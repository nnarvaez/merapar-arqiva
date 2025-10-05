import boto3
import os

def lambda_handler(event, context):
    # Connect to DynamoDB
    dynamodb = boto3.resource('dynamodb')
    table_name = os.environ.get('DYNAMODB_TABLE', 'DynamicStringTable')
    table = dynamodb.Table(table_name)

    # Fetch the saved string
    try:
        response = table.get_item(Key={'id': 'string'})
        saved_string = response['Item']['value']
    except Exception as e:
        saved_string = "Error fetching string"

    # Return HTML
    html = f"<html><body><h1>The saved string is {saved_string}</h1></body></html>"
    return {
        'statusCode': 200,
        'headers': {'Content-Type': 'text/html'},
        'body': html
    }

