macro(set_target_description target description url commit)
set_package_properties(${target}
    PROPERTIES
    URL ${url}
    DESCRIPTION ${description}
    PURPOSE "commit: ${commit}"
    )
endmacro()

function(strictmode target)
# Require pure C++14 standard.
set_target_properties(${target} PROPERTIES
    CXX_STANDARD 14
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
    )
# Enable more warnings and turn them into compile errors.
if ((CMAKE_CXX_COMPILER_ID STREQUAL "GNU") OR
(CMAKE_CXX_COMPILER_ID STREQUAL "Clang") OR
(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang"))
  target_compile_options(${target} PRIVATE -Wall -Wpedantic)
elseif ((CMAKE_CXX_COMPILER_ID STREQUAL "MSVC") OR
(CMAKE_CXX_COMPILER_ID STREQUAL "Intel"))
  target_compile_options(${target} PRIVATE /W3 /WX)
else ()
  message(AUTHOR_WARNING "Unknown compiler: building target ${target} with default options")
endif ()
endfunction()

function(JOIN VALUES GLUE OUTPUT)
  string (REGEX REPLACE "([^\\]|^);" "\\1${GLUE}" _TMP_STR "${VALUES}")
  string (REGEX REPLACE "[\\](.)" "\\1" _TMP_STR "${_TMP_STR}") #fixes escaping
  set (${OUTPUT} "${_TMP_STR}" PARENT_SCOPE)
endfunction()

# ENUM(ALGO "${ALGO}" "A" "B" "C")
# stands for: create ENUM with name ALGO, which can be A, B or C
function(ENUM variable check description)
set(options ${ARGN})
JOIN("${options}" "|" opts_pretty)
list(INSERT opts_pretty 0 "[")
list(APPEND opts_pretty "]")
JOIN("${opts_pretty}" "" opts_pretty)

#  message(STATUS "${variable}=${opts_pretty}")

# get the length of options
list(LENGTH options options_len)
if(options_len LESS 1)
  message(FATAL_ERROR "Specify at least 1 option in ENUM")
else()
  # if variable is empty
  if(NOT check)
    message(FATAL_ERROR "Specify -D${variable} with one of ${opts_pretty}")
  endif()

  # check if provided option is one of given possible options
  set(SUCCESS FALSE)
  foreach(opt ${options})
    if(opt STREQUAL ${check})
      set(SUCCESS TRUE)
    endif()
  endforeach()

  if(SUCCESS)
    message(STATUS "${variable}=${check} is selected (${description})")
  else()
    message(FATAL_ERROR "${variable}=${check} is not one of ${opts_pretty}")
  endif()
endif()
endfunction()
