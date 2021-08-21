include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

CPMAddPackage(
        NAME curl
        GIT_REPOSITORY git@github.com:curl/curl.git
        GIT_TAG origin/master)