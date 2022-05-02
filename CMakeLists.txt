# CMake minimum version. #######################################################
cmake_minimum_required(VERSION 3.21)
# Bibliography project. ########################################################
project(bibliography)

# Concateneate all bibliography files. #########################################
file(GLOB BIB_FILES "${PROJECT_SOURCE_DIR}/src/*.bib")
execute_process(
  COMMAND ${CMAKE_COMMAND} -E cat ${BIB_FILES}
  OUTPUT_VARIABLE CAT_OUTPUT
  WORKING_DIRECTORY ${PROJECT_BINARY_DIR})
file(WRITE "${PROJECT_NAME}.bib" ${CAT_OUTPUT})
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bib
        DESTINATION ${PROJECT_SOURCE_DIR})
