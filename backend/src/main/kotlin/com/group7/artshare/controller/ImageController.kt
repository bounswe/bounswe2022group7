package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("image")
class ImageController {

    @Autowired
    lateinit var imageRepository: ImageRepository

    @GetMapping("{id}")
    fun getBase64ImageById(@PathVariable("id") id: Long) : Image = imageRepository.findByIdOrNull(id) ?:
    throw ResponseStatusException(HttpStatus.NOT_FOUND, "Id is not match with any of the images in the database")

    @PostMapping()
    fun postBase64Image(@RequestBody image : Image) : Image {
        try {
            imageRepository.save(image)
            return image
        } catch (e: Exception) {
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
        }
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun deleteImage(@PathVariable id: Long) {
        if (imageRepository.existsById(id)) {
            imageRepository.deleteById(id)
        }
        else
            throw ResponseStatusException(HttpStatus.NOT_FOUND, "Id is not match with any of the items in the database")
    }

}