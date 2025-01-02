FROM ubuntu:24.04

RUN useradd -m nonrootuser && \
    mkdir -p /home/nonrootuser/app && \
    chown -R nonrootuser:nonrootuser /home/nonrootuser/app

WORKDIR /home/nonrootuser/app

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y python3.10 python3-pip python3-venv

RUN python3 -m venv /home/nonrootuser/app/venv

COPY app/dependency/requirements.txt ./

RUN /home/nonrootuser/app/venv/bin/pip install -r requirements.txt

COPY app/app.py ./
COPY app/templates/ ./templates/

EXPOSE 3000

USER nonrootuser

CMD ["/home/nonrootuser/app/venv/bin/python", "app.py"]
