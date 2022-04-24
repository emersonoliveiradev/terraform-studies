import boto3
import json
import os


region = os.environ["region"]
queue = os.environ["queue"]


def handler(event, context):
    body = json.loads(event["body"])
    messages = body.get("messages")

    sqs = boto3.client("sqs", region_name=region)

    responses = []
    for message in messages:
        payload = {"message": message}
        response = sqs.send_message(
            MessageBody=json.dumps(payload),
            QueueUrl=queue
        )
        responses.append({"payload": payload, "response": response})

    return {"statusCode": 200, "body": json.dumps(responses)}
