cmake_minimum_required(VERSION 3.26)

project(QtMediaPlayer VERSION 0.1 LANGUAGES CXX)

find_package(Qt6 6.5 REQUIRED Core COMPONENTS Quick Multimedia)
find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBAV REQUIRED IMPORTED_TARGET
    libavdevice
    libavfilter
    libavformat
    libavcodec
    libswresample
    libswscale
    libavutil
)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appQtMediaPlayer)

target_sources(appQtMediaPlayer
    PRIVATE
        main.cpp
        qthumbnail.h qthumbnail.cpp
        listitem.h


    PUBLIC
        
)

qt_add_qml_module(appQtMediaPlayer
    URI QtMediaPlayer
    VERSION 1.0

    SOURCES
    recentfileitem.h recentfileitem.cpp
    recentfilesmodel.h recentfilesmodel.cpp
    playlistmodel.h playlistmodel.cpp
    playlistitem.h playlistitem.cpp
    modelimageprovider.h


    QML_FILES 
        Window.qml
        Content.qml
        Actions.qml
        Dialogs.qml
        PlaybackControl.qml
        PlaybackSeekControl.qml
        AudioControl.qml
        PlaybackRateControl.qml

)


target_compile_features(appQtMediaPlayer PRIVATE cxx_std_20)


set_target_properties(appQtMediaPlayer PROPERTIES
    AUTORCC TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)
target_link_libraries(appQtMediaPlayer
    PRIVATE 
        Qt6::Quick
        Qt6::Multimedia
        PkgConfig::LIBAV
    )


install(TARGETS appQtMediaPlayer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)




















































#qt_add_executable(QtMediaPlayer)  //Creates and finalizes an application target of a platform-specific type.
#This command performs the following tasks:
#    1. Create a CMake target of the appropriate type for the target platform.
#    2. Link the target to the Qt::Core library.
#    3. Handle finalization of the CMake target.



# qt_standard_project_setup()     #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)

# @if %{HasTranslation}
# find_package(Qt6 REQUIRED COMPONENTS Core Quick LinguistTools)
# @else
# find_package(Qt6 REQUIRED COMPONENTS Core Quick)
# @endif

# target_sources(appQtMediaPlayer
#     PRIVATE
#         main.cpp
#         qml.qrc
#     @if %{HasTranslation}
#         %{TsFileName}
#     @endif
#         
#     PUBLIC
#         
# )

# qt_import_qml_plugins(QtMediaPlayer)
