package com.group7.artshare.service

import com.group7.artshare.DTO.*
import com.group7.artshare.repository.*
import org.springframework.stereotype.Service


@Service
class SearchService (
    private val artItemRepository: ArtItemRepository,
    private val eventInfoRepository: EventInfoRepository,
    private val physicalExhibitionRepository: PhysicalExhibitionRepository,
    private val onlineGalleryRepository: OnlineGalleryRepository,
    private val registeredUserRepository: RegisteredUserRepository,
    private val accountInfoRepository: AccountInfoRepository,
    private val discussionPostRepository: DiscussionPostRepository,
    private val artItemInfoRepository: ArtItemInfoRepository
){

    private fun searchArtItem(keys : String) : List<ArtItemDTO>{
        var infoList =  artItemInfoRepository.findFullTextSearch(keys).mapNotNull { it.id }
        return artItemRepository.findAllByArtItemInfo_IdIn(infoList).mapNotNull { it.mapToDTO() }
    }

    private fun searchPhysicalExhibition(keys:String) : List<PhysicalExhibitionDTO>{
        var infoList = eventInfoRepository.findFullTextSearch(keys).mapNotNull { it.id }
        return physicalExhibitionRepository.findAllByEventInfo_IdIn(infoList).mapNotNull { it.mapToDTO() }
    }

    private fun searchOnlineGallery(keys : String) : List<OnlineGalleryDTO>{
        var infoList = eventInfoRepository.findFullTextSearch(keys).mapNotNull { it.id }
        return onlineGalleryRepository.findAllByEventInfo_IdIn(infoList).mapNotNull { it.mapToDTO() }
    }


    private fun searchDiscussionPost(keys : String) : List<DiscussionPostDTO>{
        return discussionPostRepository.findFullTextSearch(keys).mapNotNull { it.mapToDTO() }
    }

    private fun searchUser(keys : String) : List<RegisteredUserDTO>{
        var infoList = accountInfoRepository.findFullTextSearch(keys).mapNotNull { it.id }
        return registeredUserRepository.findAllByAccountInfo_IdIn(infoList).mapNotNull { it.mapToDTO() }
    }

    fun searchArtItem(keywordList : List<String>) : List<ArtItemDTO>{

        var concatenation = ""
        for(i in keywordList){
            concatenation += i + " , "
        }

        concatenation = concatenation.subSequence(0, concatenation.length - 3).toString()
        return searchArtItem(concatenation)
    }

    fun searchPhysicalExhibition(keywordList : List<String>) : List<PhysicalExhibitionDTO>{

        var concatenation = ""
        for(i in keywordList){
            concatenation += i + " , "
        }
        concatenation = concatenation.subSequence(0, concatenation.length - 3).toString()
        return searchPhysicalExhibition(concatenation)
    }

    fun searchOnlineGallery(keywordList : List<String>) : List<OnlineGalleryDTO>{

        var concatenation = ""
        for(i in keywordList){
            concatenation += i + " , "
        }

        concatenation = concatenation.subSequence(0, concatenation.length - 3).toString()
        return searchOnlineGallery(concatenation)
    }

    fun searchDiscussionPost(keywordList : List<String>) : List<DiscussionPostDTO>{

        var concatenation = ""
        for(i in keywordList){
            concatenation += i + " , "
        }

        concatenation = concatenation.subSequence(0, concatenation.length - 3).toString()
        return searchDiscussionPost(concatenation)
    }

    fun searchUser(keywordList : List<String>) : List<RegisteredUserDTO>{

        var concatenation = ""
        for(i in keywordList){
            concatenation += i + " , "
        }

        concatenation = concatenation.subSequence(0, concatenation.length - 3).toString()
        return searchUser(concatenation)
    }

}