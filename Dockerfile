FROM python:3.12.8

RUN pip install pandas

WORKDIR /app

COPY pipeline.py pipeline.py

ENTRYPOINT [ "python","pipeline.py" ]