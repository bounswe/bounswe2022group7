package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.OnlineGalleryRequest
import com.group7.artshare.request.PhysicalExhibitionRequest
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
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

    @Autowired
    lateinit var artistRepository: ArtistRepository

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

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
    @PostMapping(value = ["physical"],  consumes=["application/json;charset=UTF-8"], produces = ["application/json;charset=UTF-8"])
    fun create(@RequestBody physicalExhibitionRequest: PhysicalExhibitionRequest) : PhysicalExhibition{
        val newPhysicalExhibition = PhysicalExhibition()
        val artist = artistRepository.findByIdOrNull(physicalExhibitionRequest.creatorId)
            ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Corresponding creatorId is not matched any of the Artist user in the database")
        newPhysicalExhibition.creator = artist;
        newPhysicalExhibition.location = physicalExhibitionRequest.location
        newPhysicalExhibition.rules = physicalExhibitionRequest.rules
        newPhysicalExhibition.eventInfo = physicalExhibitionRequest.eventInfo
        physicalExhibitionRepository.save(newPhysicalExhibition)
        return newPhysicalExhibition;
    }

    @PostMapping(value = ["online"],  consumes=["application/json;charset=UTF-8"], produces = ["application/json;charset=UTF-8"])
    fun create(@RequestBody onlineGalleryRequest: OnlineGalleryRequest) : OnlineGallery{
        val newOnlineGallery = OnlineGallery()
        val artist = artistRepository.findByIdOrNull(onlineGalleryRequest.creatorId)
            ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Corresponding creatorId is not matched any of the Artist user in the database")
        newOnlineGallery.creator = artist;
        newOnlineGallery.eventInfo = onlineGalleryRequest.eventInfo
        onlineGalleryRequest.artItemIds?.forEach {
            val artItem = artItemRepository.findByIdOrNull(it)
                ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Art item list includes an id with no corresponding art item")
            newOnlineGallery.artItems.add(artItem)
        }
        onlineGalleryRepository.save(newOnlineGallery)
        return newOnlineGallery;
    }
    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun deleteEvent(@PathVariable id: Long) {
        var physicalExhibition : PhysicalExhibition? =  physicalExhibitionRepository.findByIdOrNull(id)
        var onlineGallery : OnlineGallery? = onlineGalleryRepository.findByIdOrNull(id)
        if (physicalExhibitionRepository.existsById(id)) {
            physicalExhibitionRepository.deleteById(id)
        }
        else if (onlineGalleryRepository.existsById(id)) {
            onlineGalleryRepository.deleteById(id)
        }
        else
            throw ResponseStatusException(HttpStatus.NOT_FOUND, "Id is not match with any of the events in the database")
    }
}