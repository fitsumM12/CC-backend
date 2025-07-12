# Use the official Python image from the Docker Hub
FROM python:3.10

WORKDIR /app

# Copy the requirements file
COPY requirements.txt /app/

# Force the installation of dependencies and show progress
RUN pip install --no-cache-dir --force-reinstall -r requirements.txt --verbose
RUN apt-get update && apt-get install -y libgl1-mesa-glx

# Copy the entire Django project
COPY . /app/
EXPOSE 8010

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8010"]