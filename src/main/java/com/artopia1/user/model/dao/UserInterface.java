package com.artopia1.user.model.dao;

import com.artopia1.user.model.User;

import java.util.List;

public interface UserInterface {
    boolean registeruser(User user);
    User loginUser(String email, String password);
    List<User> getAllUsers();
    List<User> searchUsers(String keyword);
    boolean deleteUser(int id);
}
