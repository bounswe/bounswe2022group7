package com.group7.artshare.DTO

import com.group7.artshare.entity.AccountInfo
import lombok.Data
import java.util.Date
import java.util.EventListener

@Data
open class RegisteredUserDTO{
    var id : Long? = null
    var accountInfo : AccountInfo? = null
    var isVerified : Boolean? = null
    var level : Int? = null
    var xp : Double? = null
    var followingUsernames : MutableSet<String> = mutableSetOf()
    var followedByUsernames : MutableSet<String> = mutableSetOf()
    var isBanned : Boolean? = null
    var likedArtItemIds: MutableList<Long> = mutableListOf()
    var bookmarkedArtItemIds: MutableList<Long> = mutableListOf()
    var participatedEventIds : MutableList<Long> = mutableListOf()
    var bookmarkedEventIds : MutableList<Long> = mutableListOf()
    var discussionPostIds : MutableList<Long> = mutableListOf()
    var commentIds : MutableList<Long> = mutableListOf()

}
