FROM python:alpine3.7
COPY . /app
WORKDIR /app
RUN which python
RUN pip install -r requirements.txt
EXPOSE 5000
CMD python ./index.py
