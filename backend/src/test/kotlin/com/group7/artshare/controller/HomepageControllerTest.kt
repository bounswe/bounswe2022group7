package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.service.HomepageService
import com.group7.artshare.service.JwtService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito.`when`
import org.mockito.junit.jupiter.MockitoExtension
import java.util.*


@ExtendWith(MockitoExtension::class)
internal class HomepageControllerTest {

    @InjectMocks
    lateinit var homepageController: HomepageController

    @Mock
    lateinit var homepageService: HomepageService

    @Mock
    lateinit var jwtService: JwtService

    @Test
    fun successfullyReturnsArtItemList() {
        val mockArtItem1 = ArtItem()
        val mockArtItemInfo1 = ArtItemInfo()
        mockArtItem1.artItemInfo = mockArtItemInfo1
        val mockArtItem2 = ArtItem()
        val mockArtItemInfo2 = ArtItemInfo()
        mockArtItem2.artItemInfo = mockArtItemInfo2
        val mockArtItemDTOList = listOf(mockArtItem1.mapToDTO(), mockArtItem2.mapToDTO())
        `when`(homepageService.getRecommendedArtItemsGeneric()).thenReturn(mockArtItemDTOList)
        val response = homepageController.getRecommendedArtItems(null)
        assertEquals(response, mockArtItemDTOList)
    }

    @Test
    fun successfullyReturnsEventList() {
        val mockEvent1 = PhysicalExhibition()
        val mockEvent2 = OnlineGallery()
        val mockEventDTOList = listOf(mockEvent1.mapToDTO(), mockEvent2.mapToDTO())
        `when`(homepageService.getRecommendedEventsGeneric()).thenReturn(mockEventDTOList)
        val response = homepageController.getRecommendedEvents(null)
        assertEquals(response, mockEventDTOList)
    }
}