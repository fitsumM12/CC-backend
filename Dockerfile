FROM python:3.10

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y libgl1-mesa-glx && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN python -m pip install --upgrade pip

# Copy requirements first (to leverage Docker cache)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --force-reinstall -r requirements.txt --verbose

# Copy the full Django project
COPY . .

EXPOSE 8000

# Start Django dev server (for development only)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
