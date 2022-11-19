package com.group7.artshare.controller

import com.group7.artshare.DTO.ArtItemDTO
import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.ArtistRepository
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.request.ArtItemRequest
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException
import java.util.*


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("art_item")
class ArtItemController {

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
    fun deleteArtItem(@PathVariable id: Long) {
        if (artItemRepository.existsById(id)) {
            artItemRepository.deleteById(id)
        }
        else
            throw ResponseStatusException(HttpStatus.NOT_FOUND, "Id is not match with any of the art items in the database")
    }

    @PostMapping()
    fun create(@RequestBody artItemRequest: ArtItemRequest) : ArtItemDTO {
        val newArtItem = ArtItem()
        val artist = artistRepository.findByIdOrNull(artItemRequest.creatorId)
            ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Corresponding creatorId is not matched any of the Artist user in the database")
        newArtItem.creator = artist;
        newArtItem.lastPrice = artItemRequest.lastPrice!!
        newArtItem.artItemInfo = artItemRequest.artItemInfo

        val registeredUser = registeredUserRepository.findByIdOrNull(artItemRequest.ownerId)
            ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Corresponding ownerId is not matched any of the registered user in the database")
        newArtItem.owner = registeredUser;
        artItemRepository.save(newArtItem)
        return newArtItem.mapToDTO();
    }

}