package com.group7.artshare.repository

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Artist
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface AccountInfoRepository: JpaRepository<AccountInfo, Long> {
    fun findByUsername(username: String): AccountInfo?
    fun findByEmail(email: String): AccountInfo?
}