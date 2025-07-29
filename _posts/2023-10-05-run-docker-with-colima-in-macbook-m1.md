---
layout: single
title: "Run Docker with Colima in Macbook M1"
date: 2023-10-05 09:08:53 +0200
categories: development
comments: true
lang: en
tags: macbook, m1, docker, colima
image: images/cloud.jpg
---

{:refdef: style="text-align: center;"}
![Colima Docker Alternative]({{ site.baseurl }}/images/colima.jpg)
{: refdef}
{:refdef: style="text-align: center;font-size:9px"}
Foto de <a href="https://unsplash.com/es/@kylepetzer?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Kyle Petzer</a> en <a href="https://unsplash.com/es/fotos/sD_JW9vvUUA?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
{: refdef}

Since Docker Desktop is no longer <a href="https://www.docker.com/pricing/">free</a> for commercial use, developers need alternatives to run containers on macOS. <a href="https://github.com/abiosoft/colima">Colima</a> is an excellent open-source solution that allows you to run containers on macOS (and Linux) without the licensing restrictions.

In this guide, I'll show you how to set up and use Colima as a Docker Desktop alternative on your MacBook M1.

## Prerequisites

Before we begin, make sure you have:

- macOS (preferably with Apple Silicon M1/M2)
- Homebrew installed
- Basic knowledge of Docker concepts

## Installation and Setup

### Step 1: Install Colima

The installation process is straightforward using Homebrew:

```bash
brew install colima
```

### Step 2: Start the Colima VM

Launch the Colima virtual machine with your desired specifications. Here's a recommended configuration for development work:

```bash
colima start --cpu 4 --memory 8 --disk 60 docker
```

**Configuration breakdown:**

- `--cpu 4`: Allocates 4 CPU cores
- `--memory 8`: Allocates 8GB of RAM
- `--disk 60`: Allocates 60GB of disk space
- `docker`: Names the instance "docker"

You can adjust these values based on your system resources and needs.

### Step 3: Configure Docker Integration

You have two options to make Docker commands work with Colima:

#### Option A: Set DOCKER_HOST Environment Variable

1. Create or edit your `.zshenv` file:

```bash
touch ~/.zshenv
```

2. Add the following line to the file:

```bash
export DOCKER_HOST=unix://$HOME/.colima/docker/docker.sock
```

3. Reload your shell configuration:

```bash
source ~/.zshenv
```

#### Option B: Create a Symlink (Recommended)

This approach is more convenient as it doesn't require environment variable changes:

```bash
sudo ln -sfn /Users/$USER/.colima/docker/docker.sock /var/run/docker.sock
```

This creates a symbolic link that makes Colima's Docker socket available at the default Docker socket location.

## Verification

To verify that everything is working correctly, run:

```bash
docker version
docker ps
```

You should see that Docker is now connected to the Colima backend.

## Management Commands

### Stop the VM

To stop the Colima virtual machine:

```bash
colima stop
```

### List Profiles

To see all available Colima profiles:

```bash
colima ls
```

### Delete a Profile

To remove a specific Colima profile:

```bash
colima delete <profile_name>
```

### Check Docker Context

To see your current Docker context and available contexts:

```bash
docker context ls
```

## Performance Tips

- **Resource Allocation**: Adjust CPU and memory based on your workload. For heavy development, consider increasing memory to 12-16GB.
- **Disk Space**: Monitor your disk usage, especially if you work with large images.
- **Multiple Instances**: You can run multiple Colima instances with different configurations for different projects.

## Troubleshooting

If you encounter issues:

1. **Docker commands not working**: Ensure the symlink is correctly created or DOCKER_HOST is properly set
2. **Performance issues**: Try increasing CPU/memory allocation
3. **Permission errors**: Check that the Docker socket has proper permissions

## Conclusion

Colima provides a robust, free alternative to Docker Desktop for macOS users. It's particularly well-suited for Apple Silicon Macs and offers excellent performance for containerized development workflows.

The setup process is straightforward, and once configured, you can use Docker commands exactly as you would with Docker Desktop. The main advantage is that you're not limited by licensing restrictions and have full control over your container runtime environment.

Are you using Colima or another Docker Desktop alternative? Share your experience in the comments below!
