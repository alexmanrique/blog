---
layout: single
title: "Using MySQL with MCP in Cursor AI"
date: 2025-08-02 09:08:53 +0200
categories: development
comments: true
lang: en
tags: ai, cursor, mcp, mysql, database, llm
image: images/llm.jpg
---

{:refdef: style="text-align: center;"}
![AI Database Integration]({{ site.baseurl }}/images/llm.jpg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@almoya?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Aerps.com</a> on <a href="https://unsplash.com/photos/a-laptop-displays-a-search-bar-asking-how-it-can-help-0Jk1QCGMz5o?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
{: refdef}

The Model Context Protocol (MCP) is a powerful way to connect LLM services with external systems like databases, APIs, and filesystems. In this guide, I'll show you how to set up MySQL with Cursor AI using MCP, allowing you to create, modify tables, and insert data directly through natural language prompts.

## What is MCP?

Model Context Protocol (MCP) is a standardized way for AI assistants to interact with external tools and data sources. It enables LLMs to:

- Connect to databases
- Access APIs
- Read file systems
- Execute commands
- And much more

## Prerequisites

Before we begin, make sure you have:

- Docker and Docker Compose installed
- Python 3.x installed
- Cursor AI installed
- Basic knowledge of MySQL

## Step 1: Setting Up MySQL with Docker

First, let's create a MySQL container using Docker Compose. This provides a clean, isolated environment for development.

### Create docker-compose.yml

Create a `docker-compose.yml` file in your project root:

```yaml
version: "3.8"

services:
  # MySQL Database
  mysql:
    image: mysql:8.0
    container_name: cursor_mysql_db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: your_secure_password
      MYSQL_DATABASE: your_database_name
      MYSQL_USER: your_username
      MYSQL_PASSWORD: your_user_password
    volumes:
      - mysql_data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - "3306:3306"
    networks:
      - cursor_network
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      timeout: 20s
      retries: 10

volumes:
  mysql_data:

networks:
  cursor_network:
    driver: bridge
```

### Start the MySQL Container

Run the following command to start the MySQL container:

```bash
docker-compose up -d
```

This will:

- Pull the MySQL 8.0 image
- Create a container with your specified configuration
- Start the database service in the background

### Verify MySQL is Running

Check that the container is running properly:

```bash
docker-compose ps
```

You should see the MySQL container in the "Up" state.

## Step 2: Installing the MySQL MCP Server

The MySQL MCP server allows Cursor to communicate with your MySQL database. Install it using pip:

```bash
pip install mysql-mcp-server
```

## Step 3: Configuring MCP in Cursor

### Create the .cursor Directory

In your project root, create a `.cursor` directory:

```bash
mkdir .cursor
```

### Create mcp.json Configuration

Inside the `.cursor` directory, create an `mcp.json` file:

```json
{
  "mcpServers": {
    "mysql": {
      "command": "python3",
      "args": ["-m", "mysql_mcp_server.server"],
      "env": {
        "MYSQL_HOST": "localhost",
        "MYSQL_PORT": "3306",
        "MYSQL_USER": "your_username",
        "MYSQL_PASSWORD": "your_user_password",
        "MYSQL_DATABASE": "your_database_name"
      }
    }
  }
}
```

**Important**: Replace the placeholder values with your actual MySQL credentials:

- `your_username`: The MySQL user you created
- `your_user_password`: The password for that user
- `your_database_name`: The database name you specified

## Step 4: Starting the MCP Server

### Start the MySQL MCP Server

Run the MCP server to establish the connection:

```bash
python3 -m mysql_mcp_server.server
```

### Connect to Cursor

When you run the MCP server, Cursor should detect it and prompt you to connect. Click "Yes" to enable the MySQL integration.

If Cursor doesn't automatically detect the MCP server, you can manually tell the agent to use MCP by saying: "Please use MCP for database operations."

## Step 5: Using MySQL with Cursor

Now you can interact with your MySQL database using natural language prompts in Cursor. Here are some examples:

### Creating Tables

```
"Create a users table with id, name, email, and created_at fields"
```

### Inserting Data

```
"Insert a new user with name 'John Doe' and email 'john@example.com'"
```

### Querying Data

```
"Show me all users in the database"
"Find users created in the last 30 days"
```

### Modifying Tables

```
"Add a phone_number column to the users table"
"Update the email for user with id 1 to 'newemail@example.com'"
```

## Example Workflow

Here's a complete example of how to use the setup:

1. **Start the MySQL container**:

   ```bash
   docker-compose up -d
   ```

2. **Start the MCP server**:

   ```bash
   python3 -m mysql_mcp_server.server
   ```

3. **In Cursor, ask to create a table**:

   ```
   "Create a products table with id, name, price, and category fields"
   ```

4. **Insert some data**:

   ```
   "Insert three products: 'Laptop' for $999, 'Mouse' for $25, and 'Keyboard' for $75"
   ```

5. **Query the data**:
   ```
   "Show me all products with price greater than $50"
   ```

## Troubleshooting

### Common Issues

1. **Connection Refused**:

   - Ensure MySQL container is running: `docker-compose ps`
   - Check if port 3306 is available
   - Verify credentials in `mcp.json`

2. **MCP Server Not Detected**:

   - Make sure the server is running: `python3 -m mysql_mcp_server.server`
   - Check that `.cursor/mcp.json` is properly configured
   - Restart Cursor if needed

3. **Permission Denied**:
   - Verify MySQL user has proper permissions
   - Check that the database exists
   - Ensure correct credentials in configuration

### Debugging Commands

```bash
# Check if MySQL is accessible
mysql -h localhost -P 3306 -u your_username -p

# Check MCP server logs
python3 -m mysql_mcp_server.server --verbose

# Test database connection
docker exec -it cursor_mysql_db mysql -u your_username -p
```

## Best Practices

### Security Considerations

1. **Use Strong Passwords**: Always use secure passwords for MySQL users
2. **Limit Permissions**: Create a dedicated user with only necessary permissions
3. **Environment Variables**: Consider using environment variables for sensitive data
4. **Network Security**: Don't expose MySQL port to the internet in production

### Performance Tips

1. **Connection Pooling**: The MCP server handles connections efficiently
2. **Query Optimization**: Be specific in your prompts for better performance
3. **Indexing**: Ensure proper indexes for frequently queried columns

## Alternative MCP Servers

Cursor supports various MCP servers for different use cases:

- **PostgreSQL**: `postgres-mcp-server`
- **SQLite**: `sqlite-mcp-server`
- **File System**: `filesystem-mcp-server`
- **Git**: `git-mcp-server`

## Conclusion

Using MCP with MySQL in Cursor opens up powerful possibilities for database management through natural language. This setup allows you to:

- **Create and modify database schemas** using plain English
- **Insert and update data** without writing SQL manually
- **Query databases** using natural language
- **Automate database operations** as part of your development workflow

The combination of MCP, MySQL, and Cursor creates a seamless development experience where you can focus on your application logic while the AI handles the database interactions.

Remember to always review the generated SQL before executing it in production environments, and ensure your database credentials are properly secured.

Are you using MCP with other databases or tools? Share your experiences in the comments below!
