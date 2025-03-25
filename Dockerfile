FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies (use netcat-openbsd instead of netcat)
RUN apt-get update && apt-get install -y \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

# Expose port 8000 (default Django port)
EXPOSE 8005

# Run Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8005"]
