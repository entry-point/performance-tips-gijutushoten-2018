CREATE DATABASE IF NOT EXISTS webapptips CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS webapptips_test CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS webapptips_production CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

GRANT ALL ON webapptips.* TO 'webapptips'@'%' IDENTIFIED BY 'webapptips';
GRANT ALL ON webapptips_test.* TO 'webapptips'@'%' IDENTIFIED BY 'webapptips';
GRANT ALL ON webapptips_production.* TO 'webapptips'@'%' IDENTIFIED BY 'webapptips';
