package com.group7.artshare.repository

import com.group7.artshare.entity.AccountInfo
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface AccountInfoRepository: JpaRepository<AccountInfo, Long> {
    fun findByUsername(username: String): AccountInfo?
    fun findByEmail(email: String): AccountInfo?

    @Query(
        value = "SELECT * FROM account_info WHERE MATCH (name, surname, username, country) AGAINST (:searchString IN NATURAL LANGUAGE MODE)",
        nativeQuery = true
    )
    fun findFullTextSearch(@Param("searchString") searchString: String?): List<AccountInfo>
}