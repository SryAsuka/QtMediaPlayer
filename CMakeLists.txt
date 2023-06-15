cmake_minimum_required(VERSION 3.26)

project(MediaPlayer VERSION 0.1 LANGUAGES CXX)

# 配置通用编译
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
endif()

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appMediaPlayer
    main.cpp
    Resources.qrc
)

# 设置版本号
add_definitions(-DVERSION=1,0,0,0)

# 获取文件路径分隔符（解决执行命令的时候有些平台会报错）
file(TO_CMAKE_PATH "/" PATH_SEPARATOR)

# 遍历所有cpp文件
file(GLOB_RECURSE CPP_FILES *.cpp *.h)
foreach(filepath ${CPP_FILES})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
    list(APPEND sources_files ${filename})
endforeach(filepath)

# 遍历所有qml文件
file(GLOB_RECURSE QML_PATHS *.qml)
foreach(filepath ${QML_PATHS})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
    list(APPEND qml_files ${filename})
endforeach(filepath)

# 遍历所有资源文件
#file(GLOB_RECURSE RES_PATHS *.png *.jpg *.svg *.ico *.ttf *.webp qmldir)
#foreach(filepath ${RES_PATHS})
#    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
#    list(APPEND resource_files ${filename})
#endforeach(filepath)

# 添加qml模块
qt_add_qml_module(appMediaPlayer  # 这里为项目名
    URI MediaPlayer   # 项目名去掉前缀app
    VERSION 1.0
    QML_FILES ${qml_files}
    RESOURCES ${resource_files}
)

target_compile_features(appMediaPlayer PRIVATE cxx_std_20)

set_target_properties(appMediaPlayer PROPERTIES
    AUTORCC TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# 链接库
target_link_libraries(appMediaPlayer
    PRIVATE
        Qt6::Quick
)

install(TARGETS appMediaPlayer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


















































<<<<<<< HEAD
#qt_add_executable(MediaPlayer)  //Creates and finalizes an application target of a platform-specific type.
=======
#qt_add_executable(untitled4)  //Creates and finalizes an application target of a platform-specific type.
>>>>>>> b254fcf (for MajoryUi)
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

<<<<<<< HEAD
# target_sources(appMediaPlayer
=======
# target_sources(appuntitled4
>>>>>>> b254fcf (for MajoryUi)
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

<<<<<<< HEAD
# qt_import_qml_plugins(MediaPlayer)
=======
# qt_import_qml_plugins(untitled4)
>>>>>>> b254fcf (for MajoryUi)
