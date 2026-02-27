from mangum import Mangum
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from backend.core import increment_visitor

app = FastAPI()

# Add CORS middleware — handles preflight OPTIONS and all responses
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://www.isaac-douglas.com"],
    allow_methods=["GET"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"message": "Visitor Counter API is running. Use /visitor to get the count."}

@app.get("/visitor")
def get_visitor():
    count = increment_visitor()
    return JSONResponse(content={"visitor_count": count})  # header now handled by middleware

# Lambda handler
handler = Mangum(app)