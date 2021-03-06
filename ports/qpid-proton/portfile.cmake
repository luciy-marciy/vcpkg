include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_find_acquire_program(PYTHON3)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO apache/qpid-proton
    REF 77947c047f24fc7d0ddd6ba41fa14d3e8ccb3f49 # 0.30.0
    SHA512 21711081ae6fe5f791039a6295f652370e1762587b16be4fa12f5a3b4a29f6b5aee62ff25e96303ac82ba360a0682c7e92aae4419e81f9a3cf14c98fcd34b489 
    HEAD_REF next
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DPYTHON_EXECUTABLE=${PYTHON3}
        -DLIB_SUFFIX=
        -DBUILD_GO=no
        -DBUILD_RUBY=no
        -DBUILD_PYTHON=no
        -DENABLE_JSONCPP=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_CyrusSASL=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(GLOB SHARE_DIR ${CURRENT_PACKAGES_DIR}/share/*)
file(RENAME ${SHARE_DIR} ${CURRENT_PACKAGES_DIR}/share/${PORT})

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/lib/cmake/tmp)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/lib/cmake/tmp)
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/cmake/Proton ${CURRENT_PACKAGES_DIR}/lib/cmake/tmp/Proton)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/cmake/Proton ${CURRENT_PACKAGES_DIR}/debug/lib/cmake/tmp/Proton)
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/tmp/Proton TARGET_PATH share/proton)
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/ProtonCpp TARGET_PATH share/protoncpp)

file(RENAME ${CURRENT_PACKAGES_DIR}/share/${PORT}/LICENSE.txt
            ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/pkgconfig)
file(REMOVE ${CURRENT_PACKAGES_DIR}/share/qpid-proton/CMakeLists.txt)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/qpid-proton/tests)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/qpid-proton/examples)
