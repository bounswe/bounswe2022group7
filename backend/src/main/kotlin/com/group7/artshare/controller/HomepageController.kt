package com.group7.artshare.controller

import com.group7.artshare.DTO.ArtItemDTO
import com.group7.artshare.DTO.EventDTO
import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.OnlineGalleryRepository
import com.group7.artshare.repository.PhysicalExhibitionRepository
import com.group7.artshare.service.HomepageService
import com.group7.artshare.service.JwtService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException
import java.util.*


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("homepage")
class HomepageController(
    private val jwtService: JwtService, private val homepageService: HomepageService
) {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @GetMapping("event")
    fun getRecommendedEvents(
        @RequestHeader(
            value = "Authorization", required = false
        ) authorizationHeader: String?
    ): List<EventDTO> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return homepageService.getRecommendedEventsForUser(user)
            } ?: return homepageService.getRecommendedEventsGeneric()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @GetMapping("artItem")
    fun getRecommendedArtItems(
        @RequestHeader(
            value = "Authorization", required = false
        ) authorizationHeader: String?
    ): List<ArtItemDTO> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return homepageService.getRecommendedArtItemsForUser(user)
            } ?: return homepageService.getRecommendedArtItemsGeneric()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

}