package com.group7.artshare.repository

import com.group7.artshare.entity.OnlineGallery
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface OnlineGalleryRepository : JpaRepository<OnlineGallery, Long> {
    fun findAllByEventInfo_IdIn(eventInfo : List<Long>) : List<OnlineGallery>
}