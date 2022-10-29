package com.group7.artshare.repository

import com.group7.artshare.entity.RegisteredUser
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface RegisteredUserRepository : JpaRepository<RegisteredUser, Long> {
}