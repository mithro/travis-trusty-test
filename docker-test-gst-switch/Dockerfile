FROM mithro/travis-trusty:latest

MAINTAINER mithro@mithis.com

RUN git clone http://github.com/mithro/gst-switch.git
RUN cd gst-switch && ./autogen.sh --prefix=/usr && make
RUN cd gst-switch/python-api && make unittests
RUN cd gst-switch/python-api && make integration
RUN cd gst-switch && sudo make install
