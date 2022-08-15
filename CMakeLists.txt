cmake_minimum_required(VERSION 3.17)
project(CurlBuild)
set(CMAKE_CXX_STANDARD 17)

include(CMake/CPM.cmake)

find_package(OpenSSL REQUIRED)

option(BUILD_SHARED_LIBS "SharedLibs" OFF)
option(CURL_DISABLE_LDAP "Disable LDAP" ON)

add_definitions(-DCURL_STATICLIB=1)

if (APPLE)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum OS X deployment version" FORCE)
    set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE INTERNAL "")
else()
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    option(CURL_STATIC_CRT "Set to ON to build libcurl with static CRT on Windows (/MT)." ON)
endif()

CPMAddPackage(
        NAME zlib
        GIT_REPOSITORY git@github.com:madler/zlib.git
        GIT_TAG origin/master)

CPMAddPackage(
        NAME curl
        GIT_REPOSITORY git@github.com:curl/curl.git
        GIT_TAG origin/master)