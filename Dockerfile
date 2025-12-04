FROM gcc:13.2.0
WORKDIR /app
COPY waker.cpp .
COPY httplib.h .
RUN g++ -std=c++11 waker.cpp -o waker -lpthread
CMD ["./waker"]
