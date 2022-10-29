package com.group7.artshare.repository
import org.springframework.data.jpa.repository.JpaRepository
import com.group7.artshare.entity.ArtItem
import org.springframework.stereotype.Repository

@Repository
interface ArtItemRepository : JpaRepository<ArtItem, Long>{

}