package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.service.ImageService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("image")
class ImageController(private val imageService: ImageService) {
    @GetMapping("{id}")
    fun getBase64ImageById(@PathVariable("id") id: Long) : Image = imageService.getImageById(id)

    @PostMapping()
    fun postBase64Image(@RequestBody image : Image) : Map<String, Long>  = imageService.saveImage(image)

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun deleteImage(@PathVariable id: Long) = imageService.deleteImage(id)

}