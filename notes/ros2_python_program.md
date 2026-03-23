# ROS 2 - Python Program

### Create new ROS2 Package
- Create directory where the package will be located: `mkdir <name>`
- Move into the created directory, and then create a `src` directory: `mkdir src`
- Move into `src`, and then run `ros2 pkg create <name> --build-type ament_cmake`
- Move into the new directory, and then create a `/scripts` directory: `mkdir scripts`
- You can now create any Python nodes in the `scripts` directory