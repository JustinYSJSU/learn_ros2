# ROS 2 - Parameters

### Definition + Declaration
----------------------------
- A parameter is an attribute of a node which can be easily changed by users
- To declare a paramter, use declare_paramter() function in rclpy:

```
class CombinedRPM(Node):
    def __init__(self):
        super().__init__("combined_rpm_node")
        self.sub = self.create_subscription(Float32, "rpm", self.calculate_speed, 10)
        self.pub = self.create_publisher(Float32, "speed", 15)
        self.declare_parameter("wheel_radius", WHEEL_RADIUS_DEFAULT) # new addition, set wheel_radius as an actual node parameter
```

### Viewing and Setting Parameters
----------------------
- View the parameters of a node with:
`ros2 param list /<node_name>`
- View all paramters with:
`ros2 param list`
- Set a new value of a parameter with:
`ros2 param set /<node> <param_name>`

### Using Parameters
--------------------
- Use / get a paramter for use in Python with: `self.get_parameter("name").get_parameter_value.<property>`
