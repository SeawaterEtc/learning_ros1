#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/src/panda_simulator/panda_simulator_examples"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/install/lib/python3/dist-packages:/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/build/panda_simulator_examples/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/build/panda_simulator_examples" \
    "/usr/bin/python3" \
    "/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/src/panda_simulator/panda_simulator_examples/setup.py" \
     \
    build --build-base "/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/build/panda_simulator_examples" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/install" --install-scripts="/home/ubuntu20-04/ros1_workspaces/2pick_and_place_ws/install/bin"