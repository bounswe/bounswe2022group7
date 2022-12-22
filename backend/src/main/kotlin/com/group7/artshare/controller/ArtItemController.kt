package com.group7.artshare.controller

import com.group7.artshare.DTO.ArtItemDTO
import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.ArtistRepository
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.request.ArtItemRequest
import com.group7.artshare.request.ReportRequest
import com.group7.artshare.service.ArtItemService
import com.group7.artshare.service.JwtService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException
import java.util.*


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("art_item")
class ArtItemController(
    private val jwtService: JwtService,
    private val artItemService: ArtItemService
) {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @Autowired
    lateinit var artistRepository: ArtistRepository

    @Autowired
    lateinit var registeredUserRepository: RegisteredUserRepository

    @GetMapping("{id}")
    fun getRecommendedArtItemGeneric(@PathVariable("id") id: Long) : ArtItemDTO? {
        var artItem : ArtItem? = artItemRepository.findByIdOrNull(id)
        if(Objects.nonNull(artItem)){
            return artItem?.mapToDTO()
        }else
            throw ResponseStatusException(HttpStatus.NOT_FOUND, "Id is not match with any of the art items in the database")
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun delete(
        @PathVariable id: Long,
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String
    ) {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            artItemService.deleteArtItem(id, user)
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @PostMapping(
        consumes = ["application/json;charset=UTF-8"],
        produces = ["application/json;charset=UTF-8"]
    )
    fun create(
        @RequestBody artItemRequest: ArtItemRequest,
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String
    ): ArtItemDTO {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return artItemService.createArtItem(artItemRequest, user).mapToDTO()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @PostMapping("like/{id}")
    fun likeAnArtItem(
        @PathVariable("id") id: Long, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ): ArtItemDTO {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return artItemService.likeAnArtItem(id, user).mapToDTO()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @PostMapping("bookmark/{id}")
    fun bookmarkAnArtItem(
        @PathVariable("id") id: Long, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ): ArtItemDTO {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return artItemService.bookmarkAnArtItem(id, user).mapToDTO()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @PostMapping("auction/{id}")
    fun auctionAnArtItem(
        @PathVariable("id") id: Long, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ): ArtItemDTO {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return artItemService.auctionAnArtItem(id, user).mapToDTO()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

}