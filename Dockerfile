# Stage 1: Build Stage
FROM python:3.10-slim AS build

# Set the working directory in the container
WORKDIR /app
# Copy the requirements file and install all dependencies
COPY requirements.txt .

# Install all dependencies needed for building the project
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project to the container
COPY . .

# Remove unneeded libraries for runtime
RUN pip uninstall -y flask

# Stage 2: Runtime Stage
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Install only the runtime libraries
RUN pip install --no-cache-dir flask

# Expose port 8080
EXPOSE 8080

# Define environment variable
ENV FLASK_APP=app.py

# Run the application
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000"]
