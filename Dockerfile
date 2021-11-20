FROM python:3

RUN pip install --no-cache-dir ansible

WORKDIR /serverconfig

ENTRYPOINT ["./setup.sh"]
