include(FetchContent)

FetchContent_Declare(
	ImGui
	GIT_REPOSITORY https://github.com/Zalez95/imgui.git
	GIT_TAG docking-cmake
	GIT_SHALLOW TRUE
)
FetchContent_GetProperties(ImGui)
if(NOT imgui_POPULATED)
	FetchContent_Populate(ImGui)

	set(IMGUI_BUILD_EXAMPLES OFF CACHE INTERNAL "")
	set(USE_MSVC_RUNTIME_LIBRARY_DLL $<NOT:$<BOOL:${FORCE_STATIC_VCRT}>> CACHE INTERNAL "")
	set(CMAKE_INSTALL_PREFIX <INSTALL_DIR> CACHE INTERNAL "")
	set(CMAKE_BUILD_TYPE $<CONFIG> CACHE INTERNAL "")
	set(CMAKE_DEBUG_POSTFIX ${MY_DEBUG_POSTFIX} CACHE INTERNAL "")
	set(BUILD_SHARED_LIBS ${BUILD_SHARED_LIBS} CACHE INTERNAL "")

	add_subdirectory(${imgui_SOURCE_DIR} ${imgui_BINARY_DIR})
endif()
