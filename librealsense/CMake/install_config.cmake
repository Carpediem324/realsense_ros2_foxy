# Set CMAKE_INSTALL_* if not defined
set(CMAKECONFIG_INSTALL_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/${LRS_TARGET}")

if(NOT ${ROS_BUILD_TYPE})
    add_custom_target(uninstall "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")
endif()

include(CMakePackageConfigHelpers)

write_basic_package_version_file("${CMAKE_CURRENT_BINARY_DIR}/realsense2ConfigVersion.cmake"
    VERSION ${REALSENSE_VERSION_STRING} COMPATIBILITY AnyNewerVersion)

configure_package_config_file(CMake/realsense2Config.cmake.in realsense2Config.cmake
    INSTALL_DESTINATION ${CMAKECONFIG_INSTALL_DIR}
    INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/bin
    PATH_VARS CMAKE_INSTALL_INCLUDEDIR
)

if(NOT ${ROS_BUILD_TYPE})
    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake" "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake" IMMEDIATE @ONLY)
endif()
configure_file(config/librealsense.pc.in config/realsense2.pc @ONLY)

install(TARGETS ${LRS_TARGET}
    EXPORT realsense2Targets
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_PREFIX}/include/librealsense2"
)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/librealsense2
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(EXPORT realsense2Targets
        FILE realsense2Targets.cmake
        NAMESPACE ${LRS_TARGET}::
        DESTINATION ${CMAKECONFIG_INSTALL_DIR}
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/realsense2Config.cmake"
        DESTINATION ${CMAKECONFIG_INSTALL_DIR}
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/realsense2ConfigVersion.cmake"
        DESTINATION ${CMAKECONFIG_INSTALL_DIR}
)

if(NOT ${ROS_BUILD_TYPE})
       install(CODE "execute_process(COMMAND ldconfig)")
endif()

# Set library pkgconfig file for facilitating 3rd party integration
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/config/realsense2.pc"
       DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig"
)

if(${ROS_BUILD_TYPE})
      ament_export_include_directories(include)
      ament_export_libraries(${LRS_TARGET})
endif()
