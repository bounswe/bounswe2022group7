package com.group7.artshare.request

import com.group7.artshare.entity.ArtItemInfo
import lombok.Data
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty


@Data
@RequiredArgsConstructor
class ArtItemRequest {
    val creatorId: Long? = null

    @NotEmpty
    val artItemInfo: ArtItemInfo? = null

    val lastPrice: Double? = null

}