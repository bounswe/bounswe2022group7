package com.group7.artshare.repository
import com.group7.artshare.entity.ArtItem
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ArtItemRepository : JpaRepository<ArtItem, Long>{
    fun findAllByArtItemInfo_IdIn(artItemInfo : List<Long>) : List<ArtItem>
}