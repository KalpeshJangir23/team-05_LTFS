# 🧾 Lost & Found App - Backend

## 📝 About the Project

The backend module of the Lost and Found System has secure item management for lost and found, user authentication. Built with Java and Spring Boot, it offers RESTful APIs for registering/logging users, creating/retrieving/updating/deleting items, and image uploads. The modular structure ensures maintainability and scalability.

---

## 📁 Folder Structure

```
backend/
└── lostandfound/
    ├── src/
    │   └── main/
    │       ├── java/
    │       │   └── com/lostandfound/
    │       │       ├── api/
    │       │       │   ├── AuthController.java         # Authentication endpoints (register, login)
    │       │       │   └── ItemController.java         # Item CRUD APIs (create, get, update, delete, image upload)
    │       │       ├── model/
    │       │       │   ├── User.java                   # User entity/model
    │       │       │   ├── Item.java                   # Item entity/model
    │       │       │   ├── ItemStatus.java             # Enum for item status
    │       │       │   └── ItemType.java               # Enum for item type
    │       │       ├── repository/
    │       │       │   ├── UserRepository.java         # User data access interface
    │       │       │   └── ItemRepository.java         # Item data access interface
    │       │       ├── service/
    │       │       │   └── AuthService.java            # Authentication business logic
    │       │       ├── security/
    │       │       │   ├── JwtUtil.java                # JWT creation and validation utility
    │       │       │   └── SecurityConfig.java         # Spring Security configuration
    │       │       └── LostandfoundApplication.java    # Main Spring Boot application
    │   └── main/
    │       └── resources/
    │           └── application.properties              # App configuration and environment variables
    └── uploads/                                        # Uploaded item images
```

### Folder Structure
- **api/**: REST API controllers for authentication and item operations.
- **model/**: Core data entities and enums for users/items.
- **repository/**: Interfaces for database access and queries.
- **service/**: Business logic for user authentication.
- **security/**: JWT and security configuration files.
- **uploads/**: Stores uploaded images for items.
- **resources/**: Configuration properties for the backend.

---

## 📸 API Screenshots tested on Postman

**AuthController APIs**
- **Register API**  
  Endpoint: `POST /auth/register`  
  _Registers new users._  
  ![register_api_screenshot](https://github.com/user-attachments/assets/b849f611-ae61-43a9-962c-41a7dd3fcdff)

- **Login API**  
  Endpoint: `POST /auth/login`  
  _Authenticates users and returns JWT._  
  ![login_api_screenshot](https://github.com/user-attachments/assets/425366ca-87c2-4597-bb9f-a42e84d4fcba)

**ItemController APIs**
- **Create Item**  
  Endpoint: `POST /items`  
  _Creates a new item with image upload._  
  ![create_item_api_screenshot](https://github.com/user-attachments/assets/abe6fd65-562a-4ae1-8374-3e5e13b30594)

- **Get Items**  
  Endpoint: `GET /items`  
  _Retrieves a list of all items._  
  ![get_items_api_screenshot](https://github.com/user-attachments/assets/c762941a-6c94-4073-8a60-13f752a4bc7b)

- **Get Items by User**  
  Endpoint: `GET /items/psid/{psid}`  
  _Retrieves all items for a specific user._  
  ![get_items_by_user_screenshot](https://github.com/user-attachments/assets/f02971f0-dca3-43ce-9807-7c9a31e41413)
  
- **Update Item**  
  Endpoint: `PUT /items/{id}`  
  _Updates item details._  
  ![update_item_api_screenshot](https://github.com/user-attachments/assets/0e229e91-59f0-4588-85cb-2c2b27f75a3e)

- **Update Item Returned To**  
  Endpoint: `PUT /items/{id}/status`  
  _Updates the return status of an item._  
  ![update_item_returned_screenshot](https://github.com/user-attachments/assets/895463a0-3751-484e-bf4e-99e0a62acaeb)
  
- **Delete Item**  
  Endpoint: `DELETE /items/{id}`  
  _Deletes an item._  
  ![delete_item_api_screenshot](https://github.com/user-attachments/assets/7b92dbf6-6371-40a3-9191-ef46493de0c5)

---

## 👥 Team Contributions & Roles

### 1. **Altaf**
- Developed **AuthController.java** for user registration and login endpoints.
- Implemented **AuthService.java** for authentication logic.
- Built **JwtUtil.java** for secure JWT token management.

### 2. **Akshay**
- Created **UserRepository.java** and **ItemRepository.java** for database interactions.
- Configured **SecurityConfig.java** for securing endpoints and handling JWT.
- Implemented **GET** and **PUT** APIs in **ItemController.java**.

### 3. **Veerendra**
- Developed **Create** and **DELETE** APIs for items (**ItemController.java**).
- Built **WebConfig.java** for handling CORS, static resources, and image file uploads.
- Managed image upload functionality and storage in **images/** folder.
- Enabled resource creation, deletion, and media file support.

### 4. **Harsh**
- Designed all **model** classes: **User.java**, **Item.java**, **ItemStatus.java**, **ItemType.java**.
- Tested backend API for reliability and correctness.

---

## 🚀 Getting Started

1. Clone the repo and navigate to `backend/lostandfound`.
2. Configure your database and environment variables in `application.properties`.
3. Start the Spring Boot app (`mvn spring-boot:run`).
4. Test APIs using Postman, Swagger, or your preferred tool.
