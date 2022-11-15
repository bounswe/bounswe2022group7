package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.OnlineGalleryRequest
import com.group7.artshare.request.PhysicalExhibitionRequest
import com.group7.artshare.service.JwtService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException
import java.util.*


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("event")
class EventController(private val jwtService: JwtService) {

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @Autowired
    lateinit var artistRepository: ArtistRepository

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @GetMapping("{id}")
    fun getRecommendedEventsGeneric(@PathVariable("id") id: Long): Event? {
        var physicalExhibition: PhysicalExhibition? = physicalExhibitionRepository.findByIdOrNull(id)
        var onlineGallery: OnlineGallery? = onlineGalleryRepository.findByIdOrNull(id)
        if (!Objects.isNull(physicalExhibition)) {
            return physicalExhibition
        } else if (!Objects.isNull(onlineGallery)) {
            return onlineGallery
        } else
            throw ResponseStatusException(
                HttpStatus.NOT_FOUND,
                "Id is not match with any of the events in the database"
            )
    }

    fun createPhysicalExhibition(
        physicalExhibitionRequest: PhysicalExhibitionRequest,
        user: RegisteredUser
    ): PhysicalExhibition {
        val newPhysicalExhibition = PhysicalExhibition()
        if (user is Artist)
            newPhysicalExhibition.creator = user
        else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Registered users cannot create physical exhibitions")
        newPhysicalExhibition.location = physicalExhibitionRequest.location
        newPhysicalExhibition.rules = physicalExhibitionRequest.rules
        newPhysicalExhibition.eventInfo = physicalExhibitionRequest.eventInfo
        physicalExhibitionRepository.save(newPhysicalExhibition)
        return newPhysicalExhibition
    }

    @PostMapping(
        value = ["physical"],
        consumes = ["application/json;charset=UTF-8"],
        produces = ["application/json;charset=UTF-8"]
    )
    fun createPhysical(
        @RequestBody physicalExhibitionRequest: PhysicalExhibitionRequest,
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String?
    ): PhysicalExhibition {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return createPhysicalExhibition(physicalExhibitionRequest, user)
            } ?: throw Exception("Token required")
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    fun createOnlineGallery(onlineGalleryRequest: OnlineGalleryRequest, user: RegisteredUser): OnlineGallery {
        val newOnlineGallery = OnlineGallery()
        if (user is Artist)
            newOnlineGallery.creator = user
        else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Registered users cannot create online galleries")
        newOnlineGallery.eventInfo = onlineGalleryRequest.eventInfo
        onlineGalleryRequest.artItemIds?.forEach {
            val artItem = artItemRepository.findByIdOrNull(it)
                ?: throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST,
                    "Art item list includes an id with no corresponding art item"
                )
            newOnlineGallery.artItems.add(artItem)
        }
        onlineGalleryRepository.save(newOnlineGallery)
        return newOnlineGallery
    }

    @PostMapping(
        value = ["online"],
        consumes = ["application/json;charset=UTF-8"],
        produces = ["application/json;charset=UTF-8"]
    )
    fun createOnline(
        @RequestBody onlineGalleryRequest: OnlineGalleryRequest,
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String?
    ): OnlineGallery {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return createOnlineGallery(onlineGalleryRequest, user)
            } ?: throw Exception("Token required")
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun deleteEvent(@PathVariable id: Long) {
        if (physicalExhibitionRepository.existsById(id)) {
            physicalExhibitionRepository.deleteById(id)
        } else if (onlineGalleryRepository.existsById(id)) {
            onlineGalleryRepository.deleteById(id)
        } else
            throw ResponseStatusException(
                HttpStatus.NOT_FOUND,
                "Id is not match with any of the events in the database"
            )
    }
}