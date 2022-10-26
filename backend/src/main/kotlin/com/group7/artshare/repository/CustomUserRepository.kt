package com.group7.artshare.repository

import com.group7.artshare.entity.CustomUser
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*


interface CustomUserRepository : JpaRepository<CustomUser?, Long?> {
    fun findByUsername(username: String?): Optional<CustomUser?>?
}