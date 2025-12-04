FROM gcc:13.2.0
WORKDIR /app
COPY . .

RUN g++ -std=c++11 -I. waker.cpp -o waker -lpthread
CMD ["./waker"]
