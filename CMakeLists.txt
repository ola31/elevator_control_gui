cmake_minimum_required(VERSION 3.5)
project(elevator_control_gui)
# qt
set(REQUIRED_QT_VERSION 5.9.0)

# Default to C99
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 99)
endif()

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# qt creator
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)


# qt_build provides the qt cmake glue, roscpp the comms for a default talker
#find_package(catkin REQUIRED COMPONENTS qt_build roscpp cv_bridge image_transport)
find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5 COMPONENTS LinguistTools)
find_package(Qt5 COMPONENTS Qml Quick Gui REQUIRED)
find_package(ament_cmake REQUIRED)
#find_package(ament_index_cpp REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs)
find_package(elevator_interfaces)



include_directories(include)

#file(GLOB QT_FORMS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ui/*.ui)
#file(GLOB QT_RESOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} resources/*.qrc)
#file(GLOB_RECURSE QT_MOC RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} FOLLOW_SYMLINKS include/kubot_gui/*.hpp)

#add_executable(kubot_gui${QT_SOURCES} ${QT_RESOURCES_CPP} ${QT_FORMS_HPP} ${QT_MOC_HPP})

set(elevator_control_gui_cpp_SRCS
  src/main.cpp
  src/ola_view_model.cpp
  src/ola_model.cpp
)

set(elevator_control_gui_cpp_HDRS
  include/elevator_control_gui/ola_view_model.hpp
  include/elevator_control_gui/ola_model.hpp
)


set(elevator_control_gui_RESOURCES
  resources/images.qrc
  resources/qml.qrc
)

set(elevator_control_gui_dependencies
  Qt5Core
  Qt5Widgets
  ament_cmake
  rclcpp
  std_msgs
  elevator_interfaces
)


qt5_wrap_cpp(elevator_control_gui_cpp_MOCS ${elevator_control_gui_cpp_HDRS})

qt5_add_resources(elevator_control_gui_RCC ${elevator_control_gui_RESOURCES})

set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)



add_executable(elevator_control_gui ${elevator_control_gui_cpp_SRCS} ${elevator_control_gui_cpp_MOCS} ${elevator_control_gui_cpp_UIS_H} ${elevator_control_gui_RCC})
target_link_libraries(elevator_control_gui Qt5::Core)
target_link_libraries(elevator_control_gui Qt5::Qml Qt5::Quick)

ament_target_dependencies(elevator_control_gui ${elevator_control_gui_dependencies})

install(TARGETS elevator_control_gui
  DESTINATION lib/${PROJECT_NAME})

install(
  DIRECTORY resources
  DESTINATION share/${PROJECT_NAME}
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # uncomment the line when a copyright and license is not present in all source files
  #set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # uncomment the line when this package is not in a git repo
  #set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()

