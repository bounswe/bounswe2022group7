package com.group7.artshare.service

import com.group7.artshare.entity.ArtItem
import com.group7.artshare.repository.*
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.Response
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Pageable
import org.springframework.http.MediaType
import org.springframework.stereotype.Service


@Service
class SearchService (
    private val artItemRepository: ArtItemRepository,
    private val physicalExhibitionRepository: PhysicalExhibitionRepository,
    private val onlineGalleryRepository: OnlineGalleryRepository,
    private val registeredUserRepository: RegisteredUserRepository,
    private val discussionPostRepository: DiscussionPostRepository
){
    private val client = OkHttpClient()
    var API_URL = "https://api-inference.huggingface.co/models/sentence-transformers/msmarco-distilbert-base-tas-b"
    //var headers = {"Authorization": "Bearer {api_token}"}

    fun query(jsonPayload : String) : List<String>{
        val requestBody = RequestBody.create(MediaType.parse("application/json; charset=utf-8"), jsonPayload)
        val request = Request.Builder()
            .url(API_URL)
            .header("Authorization", "Bearer "+ "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" )
            .post(requestBody)
            .build()

        val response: Response = client.newCall(request).execute()
        var responseBody = response.body()?.string()
    }


    fun search(keywordList : List<String>) : List<Object>{



        var listOfArtItems = mutableListOf<ArtItem>()
        val firstPageWithTwoElements: Pageable = PageRequest.of(0, 5)
        var artItemPage = artItemRepository.findAll(firstPageWithTwoElements)
        var totalNumOfPages = artItemPage.totalPages
        var artItemsInPage = artItemPage.content
        //api call with the page given
        //listOfArtItems.add(listFromAboveLine)


        for(i in 1..totalNumOfPages){

        }


    }


}