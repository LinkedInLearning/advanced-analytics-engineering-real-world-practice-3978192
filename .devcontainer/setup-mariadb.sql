USE mariadb;
-- Using the root user, grant access to the mariadb user.
GRANT ALL PRIVILEGES ON * TO 'root' @'%' IDENTIFIED BY 'mariadb';