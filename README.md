# User Access Management

This repository contains the source code for the User Access Management system, developed to streamline access control with PostgreSQL and Apache Tomcat integration.

---

## Clone Repository

To get started, clone this repository to your local machine:

1. **Open Git Bash**.
2. Navigate to the directory where you want the cloned project to be saved.
3. Run the following command:

   ```bash
   git clone https://github.com/SagarD-123/User_Access_Management.git
   ```

---

## Apache NetBeans Setup

1. Open **Apache NetBeans**.
2. Navigate to **File** > **Open Project**.
3. Select the cloned repository folder.
4. To set up the Apache Tomcat server:
   - Go to **Services** > **Servers**.
   - Right-click on **Servers**, then select **Add Server** and follow the prompts to configure Tomcat.

---

## Database Setup

1. Open **pgAdmin 4**.
2. Navigate to **Servers** > **Databases**.
3. Right-click **Databases**, then select **Create** > **Database**.
4. Enter the database name `access_management`.
5. Navigate to `access_management` > **Schemas** > **public** > **Tables**.
6. Right-click, select **Query Tool**, paste the SQL script, and execute each table creation query sequentially.

---

## Database Configuration

To configure your database credentials in the project, make sure to update the following variables with your PostgreSQL username and password:

   ```java
   private static final String URL = "jdbc:postgresql://localhost:5432/access_management";
   private static final String USER = "postgres";
   private static final String PASSWORD = "Sagar@123";
   ```

---

## Running the Application

Once Apache Tomcat and the database are set up:

1. Right-click on the project’s root folder in NetBeans.
2. Select **Run**.
3. The application will automatically open in your browser. Alternatively, you can manually open it at: [http://localhost:9494/access-management/](http://localhost:9494/access-management/).

---

## License

THANK YOU


---


