FROM gcc:13.2.0
WORKDIR /app
COPY . .
RUN g++ -std=c++11 tracker.cpp -o tracker -lpthread   # hoặc waker.cpp -> waker
CMD ["./tracker"]  # hoặc "./waker"
