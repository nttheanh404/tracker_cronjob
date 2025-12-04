#include "httplib.h"
#include <iostream>
#include <thread>
#include <chrono>

void ping_tracker(const std::string& tracker_url) {
    std::this_thread::sleep_for(std::chrono::seconds(5)); // đợi server start
    httplib::Client cli(tracker_url.c_str());
    while (true) {
        auto res = cli.Get("/ping");
        if (res) std::cout << "[Waker] Pinged tracker: " << res->status << " " << res->body << std::endl;
        else std::cout << "[Waker] Failed to ping tracker!" << std::endl;
        std::this_thread::sleep_for(std::chrono::minutes(4));
    }
}

int main() {
    httplib::Server svr;

    svr.Get("/ping", [](const httplib::Request&, httplib::Response& res) {
        res.set_content("waker alive!", "text/plain");
        std::cout << "[Waker] Tracker pinged me!" << std::endl;
    });

    std::thread ping_thread(ping_tracker, "http://dockertesting-for-tracker.onrender.com"); // URL tracker

    std::cout << "[Waker] HTTP waker listening on port 80" << std::endl;
    svr.listen("0.0.0.0", 80);

    ping_thread.join();
}
