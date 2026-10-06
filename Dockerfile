# 1. Base image: Python 3.12 (not 3.13, because pydub needs audioop)
FROM python:3.12-slim

# 2. Make Python print logs immediately instead of buffering them
ENV PYTHONUNBUFFERED=1

# 3. Set the working directory inside the container
WORKDIR /app

# 4. Copy only requirements first (for layer caching)
COPY requirements.txt .

# 5. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy the rest of the application code
COPY . .

# 7. Document that the app listens on port 5000
EXPOSE 5000

# 8. Start the app with gunicorn on port 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
