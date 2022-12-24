package com.group7.artshare.repository
import org.springframework.data.jpa.repository.JpaRepository
import com.group7.artshare.entity.DiscussionPost
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface DiscussionPostRepository : JpaRepository<DiscussionPost, Long>{

    @Query(
        value = "SELECT * FROM discussion_post WHERE MATCH (title, text_body) AGAINST (:searchString IN NATURAL LANGUAGE MODE)",
        nativeQuery = true
    )
    fun findFullTextSearch(@Param("searchString") searchString: String?): List<DiscussionPost>
}