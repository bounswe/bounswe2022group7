package com.group7.artshare.DTO

import com.group7.artshare.entity.Location


class PhysicalExhibitionDTO :EventDTO() {
    var location : Location? = null
    var rules : String? = null
}