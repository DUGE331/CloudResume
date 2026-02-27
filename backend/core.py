import boto3
import os

# Get AWS region from environment variable
region = os.environ.get("AWS_REGION", "ap-southeast-2")

# Connect to DynamoDB
dynamodb = boto3.resource("dynamodb", region_name=region)
table = dynamodb.Table(os.environ["VISITOR_TABLE"])

def increment_visitor():
    response = table.update_item(
        Key={"record_id": "0"},  # ✅ matches your table's Partition Key
        UpdateExpression="SET #c = if_not_exists(#c, :start) + :inc",
        ExpressionAttributeNames={"#c": "record_count"},  # ✅ the column storing the count
        ExpressionAttributeValues={":inc": 1, ":start": 0},
        ReturnValues="UPDATED_NEW"
    )
    return int(response["Attributes"]["record_count"])