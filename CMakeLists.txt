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
find_package(Qt5 COMPONENTS Core Qml Quick Gui REQUIRED)
find_package(ament_cmake REQUIRED)
#find_package(ament_index_cpp REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs)
find_package(elevator_interfaces)


include_directories(include)

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
#target_link_libraries(elevator_control_gui Qt5::Core)
#target_link_libraries(elevator_control_gui Qt5::Qml Qt5::Quick)

target_link_libraries(elevator_control_gui Qt5::Core ${CMAKE_CURRENT_SOURCE_DIR}/lib/libQt5Core.so.5)
target_link_libraries(elevator_control_gui Qt5::Qml ${CMAKE_CURRENT_SOURCE_DIR}/lib/libQt5Qml.so.5)
target_link_libraries(elevator_control_gui Qt5::Quick ${CMAKE_CURRENT_SOURCE_DIR}/lib/libQt5Quick.so.5)
#target_link_libraries(elevator_control_gui Qt5::QuickControls2)

ament_target_dependencies(elevator_control_gui ${elevator_control_gui_dependencies})

install(TARGETS elevator_control_gui
  DESTINATION lib/${PROJECT_NAME})

install(
  DIRECTORY resources
  DESTINATION share/${PROJECT_NAME}
)

# install(FILES /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
#         DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/lib)
# install(FILES /usr/lib/x86_64-linux-gnu/libQt5Qml.so.5
#         DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/lib)
# install(FILES /usr/lib/x86_64-linux-gnu/libQt5Quick.so.5
#         DESTINATION lib)

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

