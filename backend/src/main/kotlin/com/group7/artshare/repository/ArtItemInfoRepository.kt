package com.group7.artshare.repository

import com.group7.artshare.entity.ArtItemInfo
import com.group7.artshare.entity.PhysicalExhibition
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ArtItemInfoRepository : JpaRepository<ArtItemInfo, Long> {

}