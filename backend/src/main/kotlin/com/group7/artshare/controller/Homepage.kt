package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.OnlineGalleryRepository
import com.group7.artshare.repository.PhysicalExhibitionRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("homepage")
class Homepage {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @GetMapping("getGenericArtItems")
    fun getRecommendedArtItemsGeneric(): List<ArtItem> {
        return artItemRepository.findAll()
    }

    @GetMapping("getGenericEvents")
    fun getRecommendedEventsGeneric(): List<Event> {
        return physicalExhibitionRepository.findAll() + onlineGalleryRepository.findAll()
    }

    @GetMapping("getEventsForUser")
    fun getRecommendedEventsForUser(): List<Event> {
        return physicalExhibitionRepository.findAll() + onlineGalleryRepository.findAll()
    }

    @GetMapping("getArtItemsForUser")
    fun getRecommendedArtItemsForUser(): List<ArtItem> {
        return artItemRepository.findAll()
    }

}