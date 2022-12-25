package com.group7.artshare.controller

import com.group7.artshare.entity.Image
import com.group7.artshare.service.ImageService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito.`when`
import org.mockito.junit.jupiter.MockitoExtension
import org.springframework.web.server.ResponseStatusException


@ExtendWith(MockitoExtension::class)
internal class ImageControllerTest {

    @InjectMocks
    lateinit var imageController: ImageController

    @Mock
    lateinit var imageService: ImageService


    @Test
    fun getBase64ImageById() {
        val image = Image("base64String")
        `when`(imageService.getImageById(image.id)).thenReturn(image)
        val result = imageController.getBase64ImageById(image.id)
        assertEquals(image, result)

    }

    @Test
    fun postBase64Image() {
        val image = Image("base64String")
        `when`(imageService.saveImage(image)).thenReturn(mapOf("id" to image.id))
        val response = imageController.postBase64Image(image)
        assert(response["id"] == image.id)
    }

    @Test
    fun deleteImage() {
        val image = Image("base64String")
        `when`(imageService.deleteImage(image.id)).thenThrow(ResponseStatusException::class.java)
        assertThrows(ResponseStatusException::class.java) { imageController.deleteImage(image.id) }
    }
}