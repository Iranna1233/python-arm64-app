# Use the arm64v8 base image for Python
FROM --platform=linux/arm64 python:3.8-slim AS builder

# Set up working directory
WORKDIR /app

# Copy the application files
COPY app.py /app

# Install dependencies
RUN pip install flask

# Expose the application's port
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
