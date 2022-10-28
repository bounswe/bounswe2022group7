package com.group7.artshare.repository


import com.group7.artshare.entity.Artist
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ArtistRepository :  JpaRepository<Artist, Long>{

}