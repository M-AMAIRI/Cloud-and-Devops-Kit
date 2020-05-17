
# Kafka Tutorial - Core Concepts


##### 1 - Introduction
Apache Kafka is a distributed publish-subscribe messaging system and a robust queue that can handle a high volume of data and enables you to pass messages from one end-point to another. Kafka is 
suitable for both offline and online message consumption. Kafka messages are persisted on the disk and replicated within the cluster to prevent data loss. Kafka is built on top of the ZooKeeper 
synchronization service.


##### 2 - Fundamentals
In this session, we will cover following things.
1. Producer
2. Consumer
3. Broker
4. Cluster
5. Topic
6. Partitions
7. Consumer groups


###### - Producer 
Producers are the publisher of messages to one or more Kafka topics. Producers send data to Kafka brokers. Every time a producer pub-lishes a message to a broker, the broker simply appends the message 
to the last segment file. Actually, the message will be appended to a partition. Producer can also send messages to a partition of their choice.

###### - Consumer
Consumers read data from brokers. Consumers subscribes to one or more topics and consume published messages by pulling data from the brokers.
###### - Broker
Brokers are simple system responsible for maintaining the pub-lished data. Each broker may have zero or more partitions per topic.
###### - Cluster
Kafka’s having more than one broker are called as Kafka cluster. A Kafka cluster can be expanded without downtime. These clusters are used to manage the persistence and replication of message data.
###### - Topic
A stream of messages belonging to a particular category is called a topic. Data is stored in topics.
Topics are split into partitions. For each topic, Kafka keeps a mini-mum of one partition.
###### - Partitions
Topics may have many partitions, so it can handle an arbitrary amount of data.
##### Workflow of Pub-Sub Messaging
Following is the step wise workflow of the Pub-Sub Messaging :
-	Producers send message to a topic at regular intervals.
-	Kafka broker stores all messages in the partitions configured for that particular topic. It ensures the messages are equally shared between partitions. If the producer sends two messages and 
there are two partitions, Kafka will store one message in the first partition and the second message in the second partition.
-	Consumer subscribes to a specific topic.
-	Once the consumer subscribes to a topic, Kafka will provide the current offset of the topic to the consumer and also saves the offset in the Zookeeper ensemble.
-	Consumer will request the Kafka in a regular interval (like 100 Ms) for new messages.
-	Once Kafka receives the messages from producers, it forwards these messages to the consumers.
-	Consumer will receive the message and process it.
-	Once the messages are processed, consumer will send an acknowledgement to the Kafka broker.
-	Once Kafka receives an acknowledgement, it changes the offset to the new value and updates it in the Zookeeper. Since offsets are maintained in the Zookeeper, the consumer can read next message 
correctly even during server outrages.
-	This above flow will repeat until the consumer stops the request.
-	Consumer has the option to rewind/skip to the desired offset of a topic at any time and read all the subsequent messages.

![alt text](https://www.tutorialspoint.com/apache_kafka/images/fundamentals.jpg)

# will be completed ...

Enjoy !
:)




M-AMAIRI



