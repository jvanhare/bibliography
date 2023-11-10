# CMake minimum version. #######################################################
cmake_minimum_required(VERSION 3.21)
# Bibliography project. ########################################################
project(bibliography)

# Find the yq program. #########################################################
find_program(CITATION_JS citation-js)
message(STATUS "Found citation-js: ${CITATION_JS}")

# Concateneate all bibliography files. #########################################
file(GLOB BIB_FILES "${PROJECT_SOURCE_DIR}/src/*.bib")
add_custom_command(
  OUTPUT ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib
  COMMAND ${CMAKE_COMMAND} -E cat ${BIB_FILES} >
          ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib
  DEPENDS ${BIB_FILES}
  COMMENT "Building ${PROJECT_NAME}.bib")
add_custom_command(
  OUTPUT ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.json
  COMMAND ${CITATION_JS} -i ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib -o
          ${PROJECT_BINARY_DIR}/${PROJECT_NAME}
  DEPENDS ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib
  COMMENT "Convert bibliography.bib to bibliography.json")
add_custom_command(
  OUTPUT ${PROJECT_BINARY_DIR}/jvanhare.json
  COMMAND ${CITATION_JS} -i ${PROJECT_SOURCE_DIR}/src/jvanhare.bib -o
          ${PROJECT_BINARY_DIR}/jvanhare
  DEPENDS ${PROJECT_SOURCE_DIR}/src/jvanhare.bib
  COMMENT "Convert jvanhare.bib to jvanhare.json")
add_custom_target(
  ${PROJECT_NAME} ALL
  DEPENDS ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib
          ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.json
          ${PROJECT_BINARY_DIR}/jvanhare.json)

install(
  FILES ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bib
        ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.json
        ${PROJECT_BINARY_DIR}/jvanhare.json DESTINATION ${PROJECT_SOURCE_DIR})
