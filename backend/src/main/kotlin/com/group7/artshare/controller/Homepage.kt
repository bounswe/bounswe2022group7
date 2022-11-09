package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.OnlineGalleryRepository
import com.group7.artshare.repository.PhysicalExhibitionRepository
import com.group7.artshare.service.JwtService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("homepage")
class Homepage(private val jwtService: JwtService) {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @GetMapping("getEvents")
    fun getRecommendedEvents(
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<Event> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return getRecommendedEventsForUser(user)
            } ?: return getRecommendedEventsGeneric()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @GetMapping("getArtItems")
    fun getRecommendedArtItems(
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<ArtItem> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return getRecommendedArtItemsForUser(user)
            } ?: return getRecommendedArtItemsGeneric()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    fun getRecommendedEventsGeneric(): List<Event> {
        return physicalExhibitionRepository.findAll() + onlineGalleryRepository.findAll()
    }

    fun getRecommendedEventsForUser(user: RegisteredUser): List<Event> {
        //        #TODO: implement this
        return physicalExhibitionRepository.findAll() + onlineGalleryRepository.findAll()
    }

    fun getRecommendedArtItemsGeneric(): List<ArtItem> {
        return artItemRepository.findAll()
    }

    fun getRecommendedArtItemsForUser(user: RegisteredUser): List<ArtItem> {
        //        #TODO: implement this
        return artItemRepository.findAll()
    }

}