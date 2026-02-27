from mangum import Mangum
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from core import increment_visitor

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://www.isaac-douglas.com"],
    allow_methods=["GET"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"message": "Visitor Counter API is running."}

@app.get("/visitor")
def get_visitor():
    count = increment_visitor()
    return JSONResponse(content={"visitor_count": count})

handler = Mangum(app)