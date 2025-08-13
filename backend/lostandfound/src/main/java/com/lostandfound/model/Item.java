package com.lostandfound.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;


@Data
@Entity
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String psid; // PS Number of finder or owner
    private String place;
    private LocalDateTime dateTime;
    private String description;
    private String itemName;

    @Lob
    private String image;

    @ElementCollection
    private List<String> tags; // comma-separated tags like "laptop bag, black, Dell"

    private boolean handedToAdmin = Boolean.TRUE ; // true if admin verified

    @Enumerated(EnumType.STRING)
    private ItemStatus status; // e.g., FOUND, RETURNED, LOST, etc.

    @Enumerated(EnumType.STRING)
    private ItemType type;   // LOST or FOUND

    @Column(nullable = true)
    private LocalDateTime returnedDate;

    @Column(nullable = true)
    private String returnedToPsid;

}