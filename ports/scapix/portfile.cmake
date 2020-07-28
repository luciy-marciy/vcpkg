vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO scapix-com/scapix
        REF df52fa1ae00f68599e482d7fc995a7e1ab5892b6
        SHA512 33ef45f7d0882ac0053127f2d88c2d955d21456479ed9f4384bf2d7314667b0a09df38293de8dd7643b86e0e40836c8d0e61aba4068f445ab28c90a4e3753841
        HEAD_REF master
)

vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        PREFER_NINJA
)

vcpkg_install_cmake()