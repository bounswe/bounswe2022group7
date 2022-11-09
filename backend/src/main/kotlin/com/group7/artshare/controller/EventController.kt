package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import java.util.*


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("event")
class EventController {

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @GetMapping("{id}")
    fun getRecommendedEventsGeneric(@PathVariable("id") id: Long) : Event? {
        var physicalExhibition : PhysicalExhibition? =  physicalExhibitionRepository.findByIdOrNull(id)
        var onlineGallery : OnlineGallery? = onlineGalleryRepository.findByIdOrNull(id)
        if (!Objects.isNull(physicalExhibition)) {
            return physicalExhibition
        }
        else if (!Objects.isNull(onlineGallery)) {
            return onlineGallery
        }
        else
            throw ResponseStatusException(HttpStatus.NOT_FOUND, "Id is not match with any of the events in the database")
    }
}