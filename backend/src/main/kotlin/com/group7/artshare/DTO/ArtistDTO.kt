package com.group7.artshare.DTO

import com.group7.artshare.entity.AccountInfo
import lombok.Data
import java.util.Date

@Data
class ArtistDTO : RegisteredUserDTO(){
    var artItems: MutableList<ArtItemDTO> = mutableListOf()
    var hostedEventIds: MutableList<Long> = mutableListOf()
    var totalSales: Int? = null
}
