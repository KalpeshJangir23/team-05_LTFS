package com.lostandfound.api;

import com.lostandfound.model.Item;
import com.lostandfound.model.ItemStatus;
import com.lostandfound.model.ItemType;
import com.lostandfound.model.User;
import com.lostandfound.repository.ItemRepository;
import com.lostandfound.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/items")
public class ItemController {
    private final ItemRepository itemRepo;
    private final UserRepository userRepo;
    public ItemController(ItemRepository itemRepo, UserRepository userRepo) {
        this.itemRepo = itemRepo;
        this.userRepo = userRepo;
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> createItem(
            @RequestParam String psid,
            @RequestParam String place,
            @RequestParam String description,
            @RequestParam String itemName,
            @RequestParam MultipartFile image,
            @RequestParam String tags,  // Expecting e.g. ["tag1","tag2"]
            @RequestParam Boolean handedToAdmin,
//            @RequestParam String status,
            @RequestParam String type
    ) {
        try {
            Item item = new Item();
            item.setId(null);
            item.setPsid(psid);
            item.setPlace(place);
            item.setDescription(description);
            item.setItemName(itemName);


            // Parse tags string into List<String>
            List<String> tagList = List.of(tags.replace("[", "")
                            .replace("]", "")
                            .replace("\"", "")
                            .split(","))
                    .stream()
                    .map(String::trim)
                    .filter(s -> !s.isEmpty())
                    .collect(Collectors.toList());
            item.setTags(tagList);

            item.setHandedToAdmin(handedToAdmin);
            item.setStatus(ItemStatus.valueOf(type.trim().toUpperCase()));
            item.setType(ItemType.valueOf(type.trim().toUpperCase()));
            item.setDateTime(LocalDateTime.now());

            // Save the image locally
            // ✅ Use absolute permanent path
            if (image != null && !image.isEmpty()) {
                String baseDir = "D:/aLntproject/team-05_LTFS/backend/lostandfound/uploads"; // choose a safe location
                File uploadFolder = new File(baseDir);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs(); // create folder if missing
                }

                // Sanitize file name
                String cleanFileName = image.getOriginalFilename().replaceAll("[^a-zA-Z0-9\\.\\-]", "_");
                String fileName = System.currentTimeMillis() + "_" + cleanFileName;

                File filePath = new File(uploadFolder, fileName);
                image.transferTo(filePath);

                // Store relative path for frontend use
                item.setImage("/uploads/" + fileName);
            }

            Item saved = itemRepo.save(item);
            return ResponseEntity.status(HttpStatus.CREATED).body(saved);

        } catch (ObjectOptimisticLockingFailureException ex) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("Conflict while saving Item: " + ex.getMessage());
        } catch (Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error while creating Item: " + ex.getMessage());
        }
    }

    @GetMapping()
    public List<Item> all() {
        return itemRepo.findAll();
    }

    @GetMapping("/psid/{psid}")
    public ResponseEntity<?> getItemsByPsid(@PathVariable String psid) {
        try {
            List<Item> items = itemRepo.findByPsid(psid);
            if (items.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("No items found for psid: " + psid);
            }
            return ResponseEntity.ok(items);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching items: " + e.getMessage());
        }
    }

    @GetMapping("/returned")
    public ResponseEntity<?> getReturnedItems() {
        try {
            List<Item> items = itemRepo.findByStatus(ItemStatus.RETURNED);

            if (items.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("No returned items found");
            }
            return ResponseEntity.ok(items);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error fetching returned items: " + e.getMessage());
        }
    }



    // --- PUT endpoint to update status (generic) ---
    @PutMapping("/{id}/status")
    @Transactional
    public ResponseEntity<?> updateStatus(@PathVariable Long id,
                                          @RequestBody Map<String, String> body) {
        String psid =body.get("psid");

        // Get user from DB and check admin
        Optional<User> optUser = userRepo.findByPsid(psid);
        if (optUser.isEmpty()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not found");
        }
        if (!Boolean.TRUE.equals(optUser.get().getIsAdmin())) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Admin privileges required");
        }

        Optional<Item> o = itemRepo.findById(id);
        if (o.isEmpty()) return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Item not found");

        Item item = o.get();

        String statusStr = body.get("status");
        if (statusStr == null) {
            return ResponseEntity.badRequest().body("Missing 'status' in request body");
        }

        ItemStatus newStatus;
        try {
            newStatus = ItemStatus.valueOf(statusStr.trim().toUpperCase());
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.badRequest().body("Invalid status. Allowed: " + java.util.Arrays.toString(ItemStatus.values()));
        }

        item.setStatus(newStatus);

        // If status becomes RETURNED, set returnedDate and optionally returnedToPsid
        if (newStatus == ItemStatus.RETURNED) {
            item.setReturnedDate(LocalDateTime.now());
            String returnedTo = body.get("returnedToPsid");
            if (returnedTo != null && !returnedTo.isBlank()) {
                item.setReturnedToPsid(returnedTo.trim());
            }
        }

        Item saved = itemRepo.save(item);
        return ResponseEntity.ok(saved);
    }


}
