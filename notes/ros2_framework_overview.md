# ROS 2 - Framework Overview

### What is ROS 2?
------------------
- Robot Operating System 
- A way to have basic functionalities built in for robot programming

### Data Distribution Service (DDS)
----------------------------------
- All code that utilizes ROS in a project is called a **Node**
- Nodes communicate with each other over a communication pipeline called **data distribution service (DDS)**
- Nodes can communicate over a DDS in 3 main ways:
    - Publisher / Subscriber
    - Service
    - Action

### Publisher & Subscriber
--------------------------
- Say there are two or more nodes present
- In **publisher / subscriber** communication, one node acts as the **publisher** (publishing data from itself). One or more nodes act as the **subscriber** (receiver the data published by the publisher)
- More specifically, the publisher publishes data about a **topic** (certain data), and the subscriber subscribes to these topics

### Service
-----------
- Say there are two nodes present
- In **service** communication, one node (service client) sends a request for data to another node (service server). The server then sends back a **response** to the client.

### Action
----------
- Say there are two nodes present
- In **action** communication, one node (action client) sends a **goal** (coordinate, etc) to another node (action server).
- The action server processes the goal, and continuously sends progress on the goal (**feedback**) until the goal is reached.
- Once the action is complete, server sends **result** back to the client

### More Features
-----------------
- **Node Parameter**: An attribute of a node that can be easily configured by users or other nodes
- **Bag File**: A file which can subscribe to multiple topics and record data as it is published. Can replay data over the same topic names
- **Package**: Contains code for robot functionality to be redistrubtued to other users