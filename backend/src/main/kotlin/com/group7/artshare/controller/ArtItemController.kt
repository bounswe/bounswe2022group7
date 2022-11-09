package com.group7.artshare.controller

import com.group7.artshare.entity.ArtItem
import com.group7.artshare.entity.Artist
import com.group7.artshare.repository.ArtItemRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("art_item")
class ArtItemController {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @GetMapping("{id}")
    fun getRecommendedArtItemsGeneric(@PathVariable("id") id: Long) : ArtItem? {
        return artItemRepository.findByIdOrNull(id)
    }

}