package com.group7.artshare.repository

import com.group7.artshare.entity.ArtItemInfo
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface ArtItemInfoRepository : JpaRepository<ArtItemInfo, Long> {
    @Query(
        value = "SELECT * FROM art_item_info WHERE MATCH (name, description, category, labels) AGAINST (:searchString IN NATURAL LANGUAGE MODE)",
        nativeQuery = true
    )
    fun findFullTextSearch(@Param("searchString") searchString: String?): List<ArtItemInfo>

}