# ROS 2 - Creating a Node (Python)

### Basics
----------
- Recall that a node is simply any piece of Python code using ROS
- So it can be a publisher, subscriber, etc...

### Create a Node - Imports
---------------------------
- Import the following:
```
import rclpy
from rclpy.node import Node
from std_msgs.msg import <type_here>
```
- `rclpy` is the Python API for ROS 2
- `Node` is the Node class from which created nodes inherit from
- `std_msgs` is the interface library which can provide data types (String, Int, etc)

### Create a Node - Class & Constructor
---------------------------------------
- Create each Node as a class which inherits from the imported `Node` class:
```
class ExampleNode(Node):
    super().__init__("node_name")
```
- After this basic declaration, you can create publisher / subscriber properties:
```
# Basic publisher
class ExampleNode(Node):
    super().__init__("node_name")
    self.pub = self.create_publisher(<interface type>, "topic_name", <queue_size>)
    self.time = self.create_timer(<freq>, self.<callback_function>) # every <freq>, run <callback_function>

    def callback_function(self):
        msg = String() # or any other interface type
        msg.data = "hi"
        self.pub.publish(msg)
def main():
    rclpy.init() # initialize ros2 communication
    my_pub = ExampleNode()
    print("Publisher running...")

    try:
        rclpy.spin(my_pub) # run until interrupt via keyboard
    except KeyboardInterrupt:
        print("Terminating node...")
        my_pub.destroy_node()

if __name__ == '__main__':
    main()
```

```
# Basic Subscriber

import rclpy # needed to use ros2 in python
from rclpy.node import Node
from std_msgs.msg import String # string message type to be used in publisher

class HelloWorldSubscriber(Node):
    def __init__(self):
        super().__init__("hello_world_sub_node")
        # msg type, topic name to subscribe to, callback function
        self.sub = self.create_subscription(String, "hello_world", self.subscriber_callback, 10)

    def subscriber_callback(self, msg):
        print("Received message: " + msg.data)

def main():
    rclpy.init() # initialize ros2 communication
    my_sub = HelloWorldSubscriber()
    print("Waiting for data to be published")

    try:
        rclpy.spin(my_sub) # run until interrupt via keyboard
    except KeyboardInterrupt:
        print("Terminating node...")
        my_sub.destroy_node()

if __name__ == '__main__':
    main()