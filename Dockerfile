ARG BASE_IMAGE

FROM $BASE_IMAGE

USER 0

RUN pip install --no-cache-dir ansible

WORKDIR /serverconfig

ENTRYPOINT ["./setup.sh"]
