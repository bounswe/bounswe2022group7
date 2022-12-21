package com.group7.artshare.controller

import com.group7.artshare.DTO.ArtItemDTO
import com.group7.artshare.DTO.DiscussionPostDTO
import com.group7.artshare.DTO.OnlineGalleryDTO
import com.group7.artshare.DTO.PhysicalExhibitionDTO
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.service.JwtService
import com.group7.artshare.service.ProfileService
import com.group7.artshare.service.SearchService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@RestController
class UserInteractionController(
    private val profileService: ProfileService,
    private val jwtService: JwtService,
    private val searchService: SearchService
) {

    @PostMapping("/follow/{username}")
    @ResponseStatus(HttpStatus.ACCEPTED)
    fun followUser(
        @PathVariable(value = "username") username: String,
        @RequestHeader(value = "Authorization", required = true) authorizationHeader: String
    ) {
        try {
            authorizationHeader.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                profileService.followUser(username , user)
            }
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }



    @GetMapping("search_art_item")
    fun searchArtItem(
        @RequestParam(value = "keywords") keywords: List<String>,
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<ArtItemDTO> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return searchService.searchArtItem(keywords)

            } ?: return searchService.searchArtItem(keywords) //if we want to customize the search results according to user, replace the method call here
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @GetMapping("search_physical_exhibition")
    fun searchPhysicalExhibition(
        @RequestParam(value = "keywords") keywords: List<String>,
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<PhysicalExhibitionDTO> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return searchService.searchPhysicalExhibition(keywords)

            } ?: return searchService.searchPhysicalExhibition(keywords) //if we want to customize the search results according to user, replace the method call here
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @GetMapping("search_online_gallery")
    fun searchOnlineGallery(
        @RequestParam(value = "keywords") keywords: List<String>,
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<OnlineGalleryDTO> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return searchService.searchOnlineGallery(keywords)

            } ?: return searchService.searchOnlineGallery(keywords) //if we want to customize the search results according to user, replace the method call here
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @GetMapping("search_discussion_post")
    fun searchDiscussionPost(
        @RequestParam(value = "keywords") keywords: List<String>,
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<DiscussionPostDTO> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return searchService.searchDiscussionPost(keywords)

            } ?: return searchService.searchDiscussionPost(keywords) //if we want to customize the search results according to user, replace the method call here
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @GetMapping("search_user")
    fun searchUser(
        @RequestParam(value = "keywords") keywords: List<String>,
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<RegisteredUser> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return searchService.searchUser(keywords)

            } ?: return searchService.searchUser(keywords) //if we want to customize the search results according to user, replace the method call here
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }
}