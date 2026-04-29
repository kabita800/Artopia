package com.artopia1.user.model.dao;

import com.artopia1.user.model.User;

public interface UserInterface {
    boolean registeruser(User user);
    User loginUser(String email, String password);
}
