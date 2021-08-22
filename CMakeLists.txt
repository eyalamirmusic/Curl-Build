cmake_minimum_required(VERSION 3.17)
project(CurlBuild)
set(CMAKE_CXX_STANDARD 17)

include(CMake/CPM.cmake)

CPMAddPackage(
        NAME openssl_source
        GIT_REPOSITORY git@github.com:openssl/openssl.git
        GIT_TAG OpenSSL_1_1_1-stable)

option(BUILD_SHARED_LIBS "SharedLibs" OFF)
option(CURL_DISABLE_LDAP "Disable LDAP" ON)

set(OPENSSL_INCLUDE_DIR ${openssl_source_SOURCE_DIR}/include CACHE INTERNAL "")

set(SSL_DIR ${CMAKE_CURRENT_LIST_DIR}/OpenSSL)
find_library(OPENSSL_SSL_LIBRARY ssl HINTS ${SSL_DIR})
find_library(OPENSSL_CRYPTO_LIBRARY crypto HINTS ${SSL_DIR})

if(APPLE)
    file(COPY ${CMAKE_CURRENT_LIST_DIR}/Sources/opensslconf.h
            DESTINATION ${OPENSSL_INCLUDE_DIR}/openssl)
endif()

set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum OS X deployment version" FORCE)
set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE INTERNAL "")
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

CPMAddPackage(
        NAME zlib
        GIT_REPOSITORY git@github.com:madler/zlib.git
        GIT_TAG origin/master)

CPMAddPackage(
        NAME curl
        GIT_REPOSITORY git@github.com:curl/curl.git
        GIT_TAG origin/master)
