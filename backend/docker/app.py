from mangum import Mangum  # Converts FastAPI to Lambda-compatible handler
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from core import increment_visitor

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Visitor Counter API is running. Use /visitor to get the count."}

@app.get("/visitor")
def get_visitor():
    count = increment_visitor()
    return JSONResponse(content={"visitor_count": count}, headers={"Access-Control-Allow-Origin": "*"})

# Lambda handler
handler = Mangum(app)