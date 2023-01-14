FROM python:3

WORKDIR /runner

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY deployment.py .

CMD [ "python", "deployment.py" ]
