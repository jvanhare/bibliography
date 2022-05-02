# CMake minimum version. #######################################################
cmake_minimum_required(VERSION 3.21)
# Bibliography project. ########################################################
project(bibliography)

# Concateneate all bibliography files. #########################################
file(GLOB BIB_FILES "${PROJECT_SOURCE_DIR}/src/*.bib")
add_custom_command(
  OUTPUT ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib
  COMMAND ${CMAKE_COMMAND} -E cat ${BIB_FILES} >
          ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib
  DEPENDS ${BIB_FILES}
  COMMENT "Building ${PROJECT_NAME}.bib")
add_custom_target(${PROJECT_NAME} ALL
                  DEPENDS ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib)
install(FILES ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib
        DESTINATION ${PROJECT_SOURCE_DIR})
