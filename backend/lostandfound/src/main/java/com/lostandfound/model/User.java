package com.lostandfound.model;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class User {
    @Id
    private String psid; //psid
    private String email;
    private String password;
    private String name;

    private Boolean isAdmin = Boolean.FALSE;
}