CREATE USER pgmaster WITH PASSWORD 'pgmaster';

GRANT ALL PRIVILEGES ON DATABASE "users" to pgmaster;