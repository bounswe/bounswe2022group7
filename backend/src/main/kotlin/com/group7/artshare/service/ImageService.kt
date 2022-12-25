package com.group7.artshare.service

import com.group7.artshare.entity.Image
import com.group7.artshare.repository.ImageRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class ImageService(private val imageRepository: ImageRepository) {

    fun getImageById(id: Long) = imageRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
        HttpStatus.NOT_FOUND, "Id is not match with any of the images in the database"
    )

    fun saveImage(image: Image): Map<String, Long> {
        try{
            imageRepository.save(image)
            return mapOf("id" to image.id)
        } catch (e: Exception){
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
        }
    }
    fun deleteImage(id: Long) =
        if (imageRepository.existsById(id)) imageRepository.deleteById(id) else throw ResponseStatusException(
            HttpStatus.NOT_FOUND, "Id is not match with any of the images in the database"
        )
}