package com.group7.artshare.repository

import com.group7.artshare.entity.RegisteredUser
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface RegisteredUserRepository : JpaRepository<RegisteredUser, Long> {
    fun findAllByAccountInfo_IdIn(accountInfo : List<Long>) : List<RegisteredUser>
}