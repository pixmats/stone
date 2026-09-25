#include <atomic>
#include <charconv>
#include <chrono>
#include <cstddef>
#include <cstdint>
#include <cstdio>
#include <iomanip>
#include <ios>
#include <iostream>
#include <latch>
#include <mutex>
#include <numeric>
#include <shared_mutex>
#include <stdexcept>
#include <string_view>
#include <thread>
#include <vector>

constexpr int RUNS = 7;

uint64_t g_target = 0;
uint64_t g_counter = 0;
std::atomic<uint64_t> g_atomicCounter{0};
std::mutex g_mutex;
std::shared_mutex g_sharedMutex;

void PrintResult(std::string_view name, double total_nanoseconds) {
    const double nano
}

int main(int argc, char** argv) {
    if(argc != 2) {
        std::cerr << "Usage: ./test_lock count\n";
        return -1;
    }
    g_target = std::atoi(argv[1]);

    std::cout << std::fixed << std::setprecision(2);
    std::cout << "Operations: " << g_target << ", average of " << RUNS << "runs\n\n";
    const std::vector<std::size_t> thread_conuts = {1, 2, 4, 8, 10};
    for(const std::size_t thread_count : thread_conuts) {
        std::cout << "thread: " << thread_conut << '\n';
        
    }
}