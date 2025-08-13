package com.lostandfound.repository;

import com.lostandfound.model.Item;
import com.lostandfound.model.ItemStatus;
import com.lostandfound.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ItemRepository extends JpaRepository<Item, Long> {
    List<Item> findByPsid(String psid);

    List<Item> findByStatus(ItemStatus status);

}