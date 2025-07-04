FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    libgl1 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# # Create virtual environment
# RUN python3 -m venv /opt/venv

# # Set environment variables to activate venv
# ENV VIRTUAL_ENV=/opt/venv
# ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY ./ ./

# # Install Open3D from the PyPI repositories
# RUN pip install --no-cache-dir --upgrade open3d

RUN pip install -r requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
