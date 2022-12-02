package com.group7.artshare.controller

import com.group7.artshare.DTO.EventDTO
import com.group7.artshare.DTO.OnlineGalleryDTO
import com.group7.artshare.DTO.PhysicalExhibitionDTO
import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.OnlineGalleryRequest
import com.group7.artshare.request.PhysicalExhibitionRequest
import com.group7.artshare.service.EventService
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
class EventController(
    private val jwtService: JwtService, private val eventService: EventService
) {

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @GetMapping("{id}")
    fun getRecommendedEventsGeneric(@PathVariable("id") id: Long): EventDTO {
        var physicalExhibition: PhysicalExhibition? = physicalExhibitionRepository.findByIdOrNull(id)
        var onlineGallery: OnlineGallery? = onlineGalleryRepository.findByIdOrNull(id)
        if (physicalExhibition != null) {
            return physicalExhibition.mapToDTO()
        } else if (onlineGallery != null) {
            return onlineGallery.mapToDTO()
        } else throw ResponseStatusException(
            HttpStatus.NOT_FOUND, "Id is not match with any of the events in the database"
        )
    }

    @PostMapping(
        value = ["physical"],
        consumes = ["application/json;charset=UTF-8"],
        produces = ["application/json;charset=UTF-8"]
    )
    fun createPhysical(
        @RequestBody physicalExhibitionRequest: PhysicalExhibitionRequest, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ): PhysicalExhibitionDTO {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return eventService.createPhysicalExhibition(physicalExhibitionRequest, user).mapToDTO()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @PostMapping(
        value = ["online"], consumes = ["application/json;charset=UTF-8"], produces = ["application/json;charset=UTF-8"]
    )
    fun createOnline(
        @RequestBody onlineGalleryRequest: OnlineGalleryRequest, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ): OnlineGalleryDTO {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return eventService.createOnlineGallery(onlineGalleryRequest, user).mapToDTO()
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
    fun deleteEvent(
        @PathVariable id: Long, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ) {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            eventService.deleteEvent(id, user)
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }
}