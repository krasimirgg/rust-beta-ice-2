FROM ubuntu:focal

RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  git \
  python3

RUN apt-get update
RUN git clone https://github.com/rust-lang/rust || true
RUN (cd rust && git checkout 3a8b0144c82197a70e919ad371d56f82c2282833)
RUN (cd rust && echo "[llvm]\ndownload-ci-llvm = true" >./config.toml)
RUN (cd rust && python3 ./x.py build -v --stage 0 library/std)

WORKDIR /example
ADD serde /example/serde
ADD serde_derive /example/serde_derive
ADD gsgdt /example/gsgdt
ADD run.sh /example/run.sh
RUN ./run.sh
