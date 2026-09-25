#include <ios>
#include <pans/mutex.h>
#include <atomic>
#include <chrono>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <latch>
#include <mutex>
#include <stdexcept>
#include <string>
#include <string_view>
#include <thread>
#include <vector>

constexpr int RUNS = 7;
uint64_t g_Counter = 0;
std::uint64_t g_target = 0;

int main(int argc, char** argv) {
    if(argc != 2) {
        std::cerr << "Usage: ./test_mutex count\n";
        return EXIT_FAILURE;
    }

    g_target = std::stoull(argv[1]);

    std::cout << std::fixed << std::setprecision(2);
    std::cout << "operations:" << g_target << ", average of " << RUNS << "runs\n\n";

    const std::vector<std::size_t> thread_couts = {1, 2, 4, 8, 10};
    for(const std::size_t thread_count : thread_couts) {
        std::cout << "thread:" << thread_count << '\n';
        Print
    }
}