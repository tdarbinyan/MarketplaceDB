CREATE SCHEMA MP;

CREATE TABLE user (
  id INTEGER PRIMARY KEY, 
  name VARCHAR(50) NOT NULL, 
  email VARCHAR(100) UNIQUE NOT NULL, 
  password VARCHAR(100) NOT NULL, 
  address VARCHAR(100) NOT NULL
);

CREATE TABLE order (
  id INTEGER PRIMARY KEY, 
  user_id INTEGER NOT NULL, 
  status VARCHAR(20) NOT NULL, 
  date TIMESTAMP NOT NULL, 
  FOREIGN KEY (user_id) REFERENCES user (id)
);

CREATE TABLE product (
  id INTEGER PRIMARY KEY, 
  name VARCHAR(100) NOT NULL, 
  description TEXT, 
  price NUMERIC(10, 2) NOT NULL, 
  available_quantity INTEGER NOT NULL
);

CREATE TABLE order_product (
  order_id INTEGER NOT NULL, 
  product_id INTEGER NOT NULL, 
  quantity INTEGER NOT NULL, 
  price_per_unit NUMERIC(10, 2) NOT NULL, 
  PRIMARY KEY (order_id, product_id), 
  FOREIGN KEY (order_id) REFERENCES order (id), 
  FOREIGN KEY (product_id) REFERENCES product (id)
);
