cmake_minimum_required(VERSION 3.17)
project(CurlBuild)
set(CMAKE_CXX_STANDARD 17)

find_package(OpenSSL)
option(BUILD_SHARED_LIBS "SharedLibs" OFF)

set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum OS X deployment version" FORCE)
set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE INTERNAL "")
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

if(APPLE)
    if (NOT OPENSSL_FOUND)
        set(OPENSSL_ROOT_DIR /opt/homebrew/opt/openssl)
    endif()
endif()

include(CMake/FindCurl.cmake)
