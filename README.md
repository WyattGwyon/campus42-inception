---
Creation: "2026-06-13 16:49"
tags:
  - "#ToLink"
  - "#ToDo"
  - "#ToTag"
Description:
Score:
---
---
*This project has been created as part of the 42 curriculum by clouden*


A “Description” section that clearly presents the project, including its goal and a
brief overview.
• An “Instructions” section containing any relevant information about compilation,
installation, and/or execution.
• A “Resources” section listing classic references related to the topic (documen-
tation, articles, tutorials, etc.), as well as a description of how AI was used —
specifying for which tasks and which parts of the project.

 A Project description section must also explain the use of Docker and the sources
included in the project. It must indicate the main design choices, as well as a
comparison between:

# ◦ Virtual Machines vs Docker
Both VMs and containers provide isolation and allow efficient sharing of host resources. They achieve this through different means.

VMs achieve this through virtualization, which in this case abstracts the physical hardware into independently running machines. Each VM is responsible for running their own OS and kernel on top of a system program called a hypervisor. This introduces significant overhead in terms of system resources. As a result, VMs can be a lot more expensive than what is required by the processes running inside them. 

Containers, on the other hand, achieve isolation by sharing the host's kernel. This greatly reduces the demand on resources which makes containers more lightweight and agile compared to VMs.

Containerization is based on Linux kernel features such as cgroups, namespaces, and union capable file system.

Namespaces control what resources (such as other processes, mount points, hostnames, and network interfaces) a process can see. Cgroups control how much system resources (CPU, I/O, and memory) a process has access to.

The Docker daemon uses a container runtime (such as containerd or runc) to create a new process with configured namespaces and cgroups. The runtime makes system calls to the Linux kernel, and the kernel enforces these isolation and resource constraints. The resulting process runs within these defined boundaries and it is called a container.

To understand containers, we need to consider processes and PID 1. In a normal Linux system, PID 1 is `init` or `systemd`, which manages system services and reaps zombie processes. In a container, PID 1 is usually the main application process, which may not be designed to handle init responsibilities like signal forwarding or zombie reaping.

In Inception, we do not strictly need to handle this issue. 

The third Linux kernel feature that enable containers is the union/overlay file system. What this means is that when a container is built from an image and other containers are built from the same image all the resources are shared. This is until one of the containers writes something, in which case it get a copy of that resource. This is called Copy on Write and it is a layer on top of the container. And this layer is only visible from the container that wrote to it. So each container will have its own copy of a resource when it modifies that resource.  This layer is only available while the container is still running. Once the container stops the layer is removed and the data is lost. This keeps resources confined and only extends more resources when modifactions are made and it provides a place for modifactions to happen. However, given that a container con only see what is inised its own container and that modifications might be needed to presist between runs of a container or even builds of a container, it becomes necessary to provide some data persistence for containers to access  in common or between runs. This is where volumes and bind mounts come in.

# ◦ Secrets vs Environment Variables


# ◦ Docker Network vs Host Network
There are several network types in Docker but by default the Bridge network is chosen. This is what is being used in Inception so I will explain it. 

The NET namespace defines what network a process lives in. And Bridge Docker Network get its own separate NET namespace.



# ◦ Docker Volumes vs Bind Mounts
Docker Volumes and Bind Mount are solving the same problem that containerization presents in regards to data persistence. The Copy on Write layer that permits container isolation from the host system disappears the moment the container is stopped. So anything that was written disappears. the only way to make data persist is to set up Docker Volume of Bind Mount. These allow data to persist through starts and stops of containers by creating a shared directory both inside the container and on the host machine. So when the container is shut down the data persists in the host machine ready when the container restarts. This also allows multiple containers to access shared data. But containers are only aware of themselves and what they contain. PID1 is the service that is running. It does not know about any process outside of itself. That is why if the volumes did not exist externally from the containers then the shared data would be hidden from the other containers. 
The difference between volumes and bind mounts is the location and responsibility. Volumes are stored inside the .docker in the host machine and Docker's API is soley responisible for creating and removing these directories. Bind Mounts are created / removed by the user somewhere else in the host machine file system. Docker cannot create or destory bind mounts.

---
#### Sources



