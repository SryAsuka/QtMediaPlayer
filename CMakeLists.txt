cmake_minimum_required(VERSION 3.26)

project(QtMediaPlayer VERSION 0.1 LANGUAGES CXX)

# 配置通用编译
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
endif()

#添加所需的包
#Qt
find_package(
    Qt6 6.5 REQUIRED
    Core COMPONENTS Quick Multimedia Core5Compat
    COMPONENTS Xml
)
#FFmpeg
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

# 设置版本号
add_definitions(-DVERSION=1,0,12,0)

# 获取文件路径分隔符（解决执行命令的时候有些平台会报错）
file(TO_CMAKE_PATH "/" PATH_SEPARATOR)

# 遍历所有cpp文件
file(GLOB_RECURSE CPP_PATHS *.cpp *.h)
foreach(filepath ${CPP_PATHS})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
    list(APPEND src_files ${filename})
endforeach(filepath)

# 遍历所有qml文件
file(GLOB_RECURSE QML_PATHS *.qml )
foreach(filepath ${QML_PATHS})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
    list(APPEND qml_files ${filename})
endforeach(filepath)


target_sources(appQtMediaPlayer

    PRIVATE

        ${src_files}
        Resources.qrc

    PUBLIC
)


# 添加qml模块
qt_add_qml_module(appQtMediaPlayer  # 这里为项目名
    URI QtMediaPlayer   # 项目名去掉前缀app
    VERSION 1.0

    QML_FILES
        ${qml_files}


)

# 遍历所有资源文件
#file(GLOB_RECURSE RES_PATHS *.png *.jpg *.svg *.ico *.ttf *.webp qmldir)
#foreach(filepath ${RES_PATHS})
#    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
#    list(APPEND resource_files ${filename})
#endforeach(filepath)

target_compile_features(appQtMediaPlayer PRIVATE cxx_std_20)

set_target_properties(appQtMediaPlayer PROPERTIES
    AUTORCC TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# 链接库
target_link_libraries(appQtMediaPlayer
    PRIVATE
        Qt6::Quick
        Qt6::Multimedia
        Qt6::Xml
        PkgConfig::LIBAV
        Qt6::Core5Compat
)

install(TARGETS appQtMediaPlayer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
