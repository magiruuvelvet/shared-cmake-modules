#include <cstdlib>
#include <string>

#if defined(PROJECT_PLATFORM_LINUX)
static const std::string platform = "linux";
#elif defined(PROJECT_PLATFORM_BSD)
static const std::string platform = "bsd";
#endif

int main()
{
    std::printf("%s (%s)\n", PROJECT_PLATFORM_NAME, platform.c_str());
    return 0;
}
