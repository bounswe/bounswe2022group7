package com.group7.artshare.repository

import com.group7.artshare.entity.EventInfo
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface EventInfoRepository : JpaRepository<EventInfo, Long> {

    @Query(
        value = "SELECT * FROM event_info WHERE MATCH (title, description, category, labels) AGAINST (:searchString IN NATURAL LANGUAGE MODE)",
        nativeQuery = true
    )
    fun findFullTextSearch(@Param("searchString") searchString: String?): List<EventInfo>
}