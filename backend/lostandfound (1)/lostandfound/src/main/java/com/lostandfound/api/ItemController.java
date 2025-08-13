package com.lostandfound.api;

import com.lostandfound.model.Item;
import com.lostandfound.repository.ItemRepository;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/items")
public class ItemController {
    private final ItemRepository itemRepo;
    public ItemController(ItemRepository itemRepo) { this.itemRepo = itemRepo; }

    @PostMapping
    public Item create(@RequestBody Item item) {
        item.setDateTime(LocalDateTime.now());
        return itemRepo.save(item);
    }

    @GetMapping
    public List<Item> all() {
        return itemRepo.findAll();
    }
}