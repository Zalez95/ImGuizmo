cmake_minimum_required(VERSION 3.11 FATAL_ERROR)

###############################################################################
# 								ImGuizmo
###############################################################################
# Project name and version
project(ImGuizmo LANGUAGES CXX)
set(IMGUIZMO_VERSION_MAJOR "1")
set(IMGUIZMO_VERSION_MINOR "0")
set(IMGUIZMO_VERSION "${IMGUIZMO_VERSION_MAJOR}.${IMGUIZMO_VERSION_MINOR}")

# Project options
option(IMGUIZMO_BUILD_EXAMPLES "Build the ImGuizmo examples" OFF)

# Dependencies
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(Dependencies)

# Find the library files
file(GLOB IMGUIZMO_SOURCES "*.cpp")
file(GLOB IMGUIZMO_HEADERS "*.h")

# Create the library
add_library(ImGuizmo ${IMGUIZMO_SOURCES})

target_include_directories(ImGuizmo PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
	$<INSTALL_INTERFACE:include>
)

# Add the compiler options
set_target_properties(ImGuizmo PROPERTIES
	CXX_STANDARD			11
	CXX_STANDARD_REQUIRED	On
	DEBUG_POSTFIX			"d"
)
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
	target_compile_options(ImGuizmo PRIVATE -Wall -Wno-unused-variable -Wno-unused-function -Wno-sign-compare)
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
	target_compile_options(ImGuizmo PRIVATE /W4 -D_CRT_SECURE_NO_WARNINGS)

	option(FORCE_STATIC_VCRT "Force /MT for static VC runtimes" OFF)
	if(FORCE_STATIC_VCRT)
		foreach(flagVar
			CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
			CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO
		)
			if(${flagVar} MATCHES "/MD")
				string(REGEX REPLACE "/MD" "/MT" ${flagVar} "${${flagVar}}")
			endif()
		endforeach()
	endif()
endif()

# Link the dependencies
target_link_libraries(ImGuizmo PUBLIC ImGui)

# Install the library
install(TARGETS ImGuizmo EXPORT ImGuizmoTargets
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
	RUNTIME DESTINATION bin
	INCLUDES DESTINATION include
)
install(EXPORT ImGuizmoTargets
	FILE ImGuizmoTargets.cmake
	NAMESPACE ImGuizmo::
	DESTINATION lib/cmake/ImGuizmo
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file("ImGuizmoConfigVersion.cmake"
	VERSION ${IMGUIZMO_VERSION}
	COMPATIBILITY SameMajorVersion
)
install(FILES "ImGuizmoConfig.cmake" "ImGuizmoConfigVersion.cmake"
	DESTINATION lib/cmake/ImGuizmo
)

# Create the examples
if(IMGUIZMO_BUILD_EXAMPLES)
	message(FATAL_ERROR "Examples not implemented yet")
endif()
