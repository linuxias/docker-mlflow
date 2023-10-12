FROM ubuntu:20.04

LABEL maintainer = "Seungha Son <linuxias@gmail.com>"

ENV APP_PATH /opt/apps
ENV HOME /root
ENV PYTHON_VERSION 3.10.5
ENV PYTHON_ROOT /usr/local/python-$PYTHON_VERSION
ENV PATH $PYTHON_ROOT/bin:$HOME/.local/bin:$PATH
ENV PYENV_ROOT $HOME/.pyenv
ENV DEBIAN_FRONTEND noninteractive

# For solving tzdata hang problem
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG mlflow_version

WORKDIR ${APP_PATH}
COPY . ${APP_PATH}

RUN apt update
RUN ./build.sh
ENTRYPOINT ["sh", "-c"]
CMD ["mlflow server --backend-store-uri sqlite:////root/example.db --host 0.0.0.0"]
