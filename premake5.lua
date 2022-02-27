workspace "nakao"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["imgui"] = "vendor/imgui"
IncludeDir["glfw"] = "vendor/glfw/include"

include "vendor/imgui"
include "vendor/glfw"

project "nakao"
	location "nakao"
	kind "ConsoleApp"
	language "C++"
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("intermediates/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/src/**.hpp",
		"%{prj.name}/src/**.c",
	}

	includedirs
	{
		"%{prj.name}/src/Public",
		"%{IncludeDir.imgui}",
		"%{IncludeDir.glfw}"
	}

	links
	{
		"ImGui",
		"GLFW"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"NAKAO_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "NAKAO_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "NAKAO_RELEASE"
		optimize "On"
