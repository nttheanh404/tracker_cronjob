FROM gcc:13.2.0
WORKDIR /app
COPY . .
RUN g++ -std=c++11 waker.cpp -o waker -lpthread   # hoặc waker.cpp -> waker
CMD ["./waker"]  # hoặc "./waker"
