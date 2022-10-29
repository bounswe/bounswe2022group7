package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.EventInfoRepository
import com.group7.artshare.repository.OnlineGalleryRepository
import com.group7.artshare.repository.PhysicalExhibitionRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.util.*


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("event")
class EventController {

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @Autowired
    lateinit var eventInfoRepository: EventInfoRepository

    @GetMapping("{id}")
    fun getRecommendedEventsGeneric(@PathVariable("id") id: Long) : Event? {
        var physicalExhibition : PhysicalExhibition? =  physicalExhibitionRepository.findByIdOrNull(id)
        var onlineGallery : OnlineGallery? = onlineGalleryRepository.findByIdOrNull(id)
        if (Objects.isNull(physicalExhibition)) {
            return onlineGallery
        }
        return physicalExhibition
    }
}