package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.request.ArtItemRequest
import com.group7.artshare.service.ArtItemService
import com.group7.artshare.service.JwtService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("art_item")
class ArtItemController(
    private val jwtService: JwtService,
    private val artItemService: ArtItemService
) {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @GetMapping("{id}")
    fun getRecommendedArtItemsGeneric(@PathVariable("id") id: Long): ArtItem =
        artItemRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
            HttpStatus.NOT_FOUND,
            "Id is not match with any of the art items in the database"
        )

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
    ): ArtItem {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return artItemService.createArtItem(artItemRequest, user)
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

}