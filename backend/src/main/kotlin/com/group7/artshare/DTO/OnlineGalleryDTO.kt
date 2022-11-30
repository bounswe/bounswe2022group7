package com.group7.artshare.DTO


class OnlineGalleryDTO : EventDTO() {
    var artItemList: MutableList<ArtItemDTO> = mutableListOf()
    var externalUrl : String? = null
}