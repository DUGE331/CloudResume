import json
from docker.core import increment_visitor

def lambda_handler(event, context):
    count = increment_visitor()
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"visitor_count": count})
    }