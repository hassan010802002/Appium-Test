web: chmod +x setup.sh
web: ./setup.sh
web: pip install -r requirements.txt 
web: uvicorn main:app --host 0.0.0.0 --port 8000
web: appium -a 0.0.0.0 -p 5000 